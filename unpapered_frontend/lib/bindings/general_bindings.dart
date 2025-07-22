import 'package:get/get.dart';
import 'package:unpapered/utils/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
