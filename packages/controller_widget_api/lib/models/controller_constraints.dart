import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'controller_constraints.freezed.dart';

@freezed
class ControllerConstraints with _$ControllerConstraints {
  const ControllerConstraints._();
  const factory ControllerConstraints(
      {@Default((Constraints.start, Constraints.top))
      (Constraints, Constraints)? constraints,
      @Default(AbsoluteOffset(0.0)) Offset? offsetx,
      @Default(AbsoluteOffset(0.0)) Offset? offsety}) = _ControllerConstraints;
  factory ControllerConstraints.fromXml(CustomProperties? props) {
    if (props == null) return ControllerConstraints();
    if (props.getValue("constraints") == null)
      throw ControllerConstraintsException;
    var values = props
        .getValue("constraints")
        .toString()
        .split('|')
        .map((e) => (EnumToString.fromString(Constraints.values, e)))
        .toList();
    var constraints = values.length == 2 ? (values[0]!, values[1]!) : null;

    return ControllerConstraints(
      constraints: constraints,
      offsetx: parseOffset(props.getValue("offsetx")),
      offsety: parseOffset(props.getValue("offsety")),
    );
  }
  static Offset? parseOffset(String? attr) {
    if (attr == null) return null;
    var match = RegExp("(\d+)%").stringMatch(attr);
    if (match == null)
      return double.tryParse(attr) != null
          ? AbsoluteOffset(double.tryParse(attr)!)
          : null;
    return double.tryParse(attr) != null
        ? RelativeOffset(double.tryParse(attr)!)
        : null;
  }
}

enum Constraints { top, bottom, start, end }

abstract class Offset {
  final double value;
  const Offset(this.value);
}

class RelativeOffset extends Offset {
  const RelativeOffset(super.value);
}

class AbsoluteOffset extends Offset {
  const AbsoluteOffset(super.value);
}

class ControllerConstraintsException {}
