import 'dart:async';

import 'package:controller_widget_api/models/controller_constraints.dart';
import 'package:flame/components.dart';

class ViewComponent extends PositionComponent with HasGameRef {
  ControllerConstraints constraints;
  ViewComponent({ControllerConstraints? constraints})
      : constraints = constraints ?? const ControllerConstraints();

  @override
  void update(double dt) {
    super.update(dt);
    var pos = getConstraintsPosition();
    position.x = pos.x;
    position.y = pos.y;
  }

  ({double x, double y}) getConstraintsPosition() {
    // TODO: handle x then y, then offset (absolute or relative)
    var x = 0.0;
    var y = 0.0;
    // size.y

    return (x: x, y: y);
  }
}
