import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_mjpeg/flame_mjpeg.dart';
import 'package:meta/meta.dart';

get createStream => StreamController();

class MjpegStreamComponent extends PositionComponent {
  MjpegStreamComponent({
    required Uri uri,
    SpriteAnimation? animation,
    bool? autoResize,
    Paint? paint,
    this.playing = true,
    this.removeOnFinish = false,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  })  : _autoResize = autoResize ?? size == null,
        frameController = StreamController() {
    manager = MjpegManager(uri: uri, frameController: frameController);
  }
  MjpegStreamComponent.parseUri({
    required String uri,
    SpriteAnimation? animation,
    Map<String, String>? headers,
    bool? autoResize,
    Paint? paint,
    this.playing = true,
    this.removeOnFinish = false,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  })  : _autoResize = autoResize ?? size == null,
        frameController = StreamController() {
    manager = MjpegManager(
        uri: Uri.parse(uri),
        frameController: frameController,
        headers: headers);
  }
  late MjpegManager manager;
  StreamController<Image?> frameController;

  /// If the component should be removed once the animation has finished.
  Image? frame;

  /// If the component should be removed once the animation has finished.
  /// Needs the animation to have `loop = false` to ever remove the component,
  /// since it will never finish otherwise.
  bool removeOnFinish;

  /// Whether the animation is paused or playing.
  bool playing;

  /// When set to true, the component is auto-resized to match the
  /// size of current animation sprite.
  bool _autoResize;
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    manager.updateStream();
    //TODO: if multiple listeners can't be set here, place frame controller update in the [update] method
    frameController.stream.listen((event) {
      frame = event;
    }).onError((e) {
      print(e);
      // TODO: snackbar error message
      frame = null;
    }); // TODO: print error message
  }

  Sprite? get sprite => frame != null ? Sprite(frame!) : null;

  /// Returns current value of auto resize flag.
  bool get autoResize => _autoResize;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    sprite?.render(canvas, size: size);
  }

  @mustCallSuper
  @override
  void update(double dt) {
    // TODO: if not playing pause subscription
    if (playing) {
      // _animationTicker?.update(dt);
      _resizeToSprite();
      // print('sprite != null ${sprite != null}');
    }
    if (removeOnFinish /* && (_animationTicker?.done() ?? false) */) {
      removeFromParent();
    }
  }

  @override
  void onRemove() {
    manager.dispose();
    frameController.close();
  }

  /// Sets the given value of autoResize flag. Will update the [size]
  /// to fit srcSize of current sprite if set to  true.
  set autoResize(bool value) {
    _autoResize = value;
    _resizeToSprite();
  }

  /// This flag helps in detecting if the size modification is done by
  /// some external call vs [_autoResize]ing code from [_resizeToSprite].
  bool _isAutoResizing = false;

  /// Updates the size to current [animation] sprite's srcSize if
  /// [autoResize] is true.
  void _resizeToSprite() {
    if (_autoResize) {
      _isAutoResizing = true;

      final newX = sprite?.srcSize.x ?? 0;
      final newY = sprite?.srcSize.y ?? 0;

      // Modify only if changed.
      if (size.x != newX || size.y != newY) {
        size.setValues(newX, newY);
      }

      _isAutoResizing = false;
    }
  }

  /// Turns off [_autoResize]ing if a size modification is done by user.
  void _handleAutoResizeState() {
    if (_autoResize && (!_isAutoResizing)) {
      _autoResize = false;
    }
  }
}
