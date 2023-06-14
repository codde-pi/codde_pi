import 'package:codde_pi/core/widgets/api/widget_parser.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:get/get.dart';

class CoddeControllerController extends GetxController {
  ControllerWidgetMode mode;
  String? path;
  CoddeControllerController(
      {this.path, this.mode = ControllerWidgetMode.player, mapTree});

  final mapTreeController = TreeViewController().obs;

  void editMode() {
    mode = ControllerWidgetMode.editor;
    update();
  }

  void playMode() {
    mode = ControllerWidgetMode.player;
    update();
  }

  void toggleMode() {
    mode == ControllerWidgetMode.editor
        ? ControllerWidgetMode.player
        : ControllerWidgetMode.editor;
    update();
  }

  void setPath(String path) {
    this.path = path;
    this.mode = ControllerWidgetMode.player;
    update();
  }
}
