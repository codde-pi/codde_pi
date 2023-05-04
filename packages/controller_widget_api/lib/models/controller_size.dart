import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'controller_size.g.dart';

const TILE_SIZE = 50.0;

@JsonSerializable()
class ControllerSize extends Equatable {
  final int width;
  final int height;

  ControllerSize(this.width, this.height);

  @override
  List<Object?> get props => [width, height];

  ControllerSize copyWith({int? width, int? height}) {
    return ControllerSize(width ?? this.width, height ?? this.height);
  }

  static ControllerSize fromJson(Map<String, dynamic> json) =>
      _$ControllerSizeFromJson(json);

  /// Converts this [ControllerSize] into a [Map].
  Map<String, dynamic> toJson() => _$ControllerSizeToJson(this);
}
