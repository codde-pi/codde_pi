import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'controller_background.g.dart';

@JsonSerializable()
class ControllerBackground extends Equatable {
  // final ControllerSize size; // not toJson
  final String name;
  // final Image image;
  final String source; // image path
  // TODO: firstgid

  ControllerBackground(
      {required this.name,
      // required this.image,
      required this.source});

  ControllerBackground copyWith({String? name, Image? image, String? source}) {
    return ControllerBackground(
        name: name ?? this.name,
        // image: image ?? this.image,
        source: source ?? this.source);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, /* image, */ source];

  /// Deserializes the given [Map] into a [ControllerBackground].
  static ControllerBackground fromJson(Map<String, dynamic> json) =>
      _$ControllerBackgroundFromJson(json);

  /// Converts this [ControllerBackground] into a [Map].
  Map<String, dynamic> toJson() => _$ControllerBackgroundToJson(this);
}
