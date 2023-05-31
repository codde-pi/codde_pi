import 'package:codde_pi/app/pages/codde/state/codde_project_controller.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_controller.dart';
import 'package:get/get.dart';

class CoddeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<DynamicBarController>(() => DynamicBarController(
        destinations: [DynamicBarPager.controller, DynamicBarPager.editor]));
    Get.lazyPut<CoddeProjectController>(
        () => CoddeProjectController(Get.arguments));
  }
}
