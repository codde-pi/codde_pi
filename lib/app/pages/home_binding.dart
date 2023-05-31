import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_pager.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<DynamicBarController>(() => DynamicBarController(
            destinations: [
              DynamicBarPager.globalProjects,
              DynamicBarPager.dummyDestination
            ]));
  }
}
