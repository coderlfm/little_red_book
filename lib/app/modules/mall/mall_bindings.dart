import 'package:get/get.dart';
import './mall_controller.dart';

class MallBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(MallController());
    }
}