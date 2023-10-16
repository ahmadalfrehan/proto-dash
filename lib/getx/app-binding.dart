import 'package:get/get.dart';
import 'package:proto_dashbord/getx/app-controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
  }
}
