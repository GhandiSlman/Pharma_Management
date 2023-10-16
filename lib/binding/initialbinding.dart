import 'package:get/get.dart';
import 'package:pharma_man/controllers/auth/login_controller.dart';

class InintialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(),fenix: true);
  }
}
