import 'package:codde_pi/core/widgets/templates/widget_player.dart';
import 'package:flutter/widgets.dart';

part 'unkown_button_painter.dart';

class UnknownButtonPlayer extends WidgetPlayer {
  UnknownButtonPlayer(
      {required super.id,
      super.position,
      super.svg,
      required super.pressedSvg});
}
