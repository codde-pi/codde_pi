import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'controller_position.g.dart';

@JsonSerializable()
class ControllerPosition extends Equatable {
  final int x;
  final int y;

  ControllerPosition(this.x, this.y);

  @override
  List<Object?> get props => [x, y];

  ControllerPosition copyWith({int? x, int? y}) {
    return ControllerPosition(x ?? this.x, y ?? this.y);
  }

  static ControllerPosition fromJson(Map<String, dynamic> json) =>
      _$ControllerPositionFromJson(json);

  /// Converts this [ControllerPosition] into a [Map].
  Map<String, dynamic> toJson() => _$ControllerPositionToJson(this);
}
