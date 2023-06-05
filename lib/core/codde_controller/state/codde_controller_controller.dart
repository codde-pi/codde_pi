import 'package:codde_pi/core/widgets/api/widget_parser.dart';
import 'package:get/get.dart';

class CoddeControllerController extends GetxController {
  ControllerWidgetMode mode;
  CoddeControllerController({this.mode = ControllerWidgetMode.player});

  void editMode() {
    mode = ControllerWidgetMode.editor;
  }

  void playMode() {
    mode = ControllerWidgetMode.player;
  }

  void toggleMode() {
    mode == ControllerWidgetMode.editor
        ? ControllerWidgetMode.player
        : ControllerWidgetMode.editor;
  }
}
