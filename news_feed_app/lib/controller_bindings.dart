import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/theme_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController());
  }
}
