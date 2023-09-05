import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:http/http.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

/// A preprocessor for each JPEG frame from an MJPEG stream.
class MjpegPreprocessor {
  List<int>? process(List<int> frame) => frame;
}

class MjpegManager {
  static const _trigger = 0xFF;
  static const _soi = 0xD8;
  static const _eoi = 0xD9;

  final Uri uri;
  final bool isLive;
  final Duration _timeout;
  final Map<String, String>? headers;
  final Client _httpClient;
  List<int>? Function(List<int>)? preprocessor;
  final bool _mounted = true;
  // ignore: cancel_subscriptions
  StreamSubscription? _subscription;
  StreamController<Image?> frameController;

  MjpegManager({
    required this.uri,
    this.isLive = true,
    this.headers,
    Duration? timeout,
    Client? httpClient,
    this.preprocessor,
    required this.frameController,
  })  : _timeout = timeout ?? const Duration(seconds: 2),
        _httpClient = httpClient ?? Client();

  Future<void> dispose() async {
    if (_subscription != null) {
      await _subscription!.cancel();
      _subscription = null;
    }
    _httpClient.close();
  }

  void _sendImage(List<int> chunks) async {
    // pass image through preprocessor sending to [Image] for rendering
    final List<int>? imageData =
        preprocessor != null ? preprocessor!(chunks) : chunks;
    if (imageData == null) return;

    decodeImageFromList(Uint8List.fromList(imageData))
        .then((value) => frameController.add(value));
  }

  void updateStream() async {
    try {
      final request = Request("GET", uri);
      if (headers != null) request.headers.addAll(headers!);
      final response = await _httpClient.send(request).timeout(
          _timeout); //timeout is to prevent process to hang forever in some case

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var _carry = <int>[];
        _subscription = response.stream.listen((chunk) async {
          if (_carry.isNotEmpty && _carry.last == _trigger) {
            if (chunk.first == _eoi) {
              _carry.add(chunk.first);
              _sendImage(_carry);
              _carry = [];
              if (!isLive) {
                dispose();
              }
            }
          }

          for (var i = 0; i < chunk.length - 1; i++) {
            final d = chunk[i];
            final d1 = chunk[i + 1];

            if (d == _trigger && d1 == _soi) {
              _carry = [];
              _carry.add(d);
            } else if (d == _trigger && d1 == _eoi && _carry.isNotEmpty) {
              _carry.add(d);
              _carry.add(d1);

              _sendImage(_carry);
              _carry = [];
              if (!isLive) {
                dispose();
              }
            } else if (_carry.isNotEmpty) {
              _carry.add(d);
              if (i == chunk.length - 2) {
                _carry.add(d1);
              }
            }
          }
        }, onError: (error, stack) {
          try {
            if (_mounted) {
              frameController.addError(error, stack);
            }
          } catch (ex) {}
          dispose();
        }, cancelOnError: true);
      } else {
        if (_mounted) {
          frameController.addError(
              HttpException('Stream returned ${response.statusCode} status'),
              StackTrace.current);
        }
        dispose();
      }
    } catch (error, stack) {
      // we ignore those errors in case play/pause is triggers
      if (!error
          .toString()
          .contains('Connection closed before full header was received')) {
        if (_mounted) {
          frameController.addError(error, stack);
        }
      }
    }
  }
}
