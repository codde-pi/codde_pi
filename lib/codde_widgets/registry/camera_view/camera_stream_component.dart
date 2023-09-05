import 'dart:ui';

import 'package:codde_pi/codde_widgets/templates/view_component.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:controller_widget_api/models/controller_constraints.dart';
import 'package:flame/components.dart';
import 'package:flame_mjpeg/flame_mjpeg.dart';

class CameraStreamComponent extends MjpegStreamComponent with HasGameRef {
  ControllerConstraints constraints;
  CameraStreamComponent(
      {ControllerConstraints? constraints, required properties})
      : assert(properties.getValue('uri') != null, "No URI provided"),
        constraints = constraints ?? const ControllerConstraints(),
        super(uri: properties.getValue('uri'));

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
