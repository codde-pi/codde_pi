import 'package:codde_pi/core/codde_controller/state/codde_controller_controller.dart';
import 'package:get/get.dart';

class CoddeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CoddeControllerController());
  }
}
