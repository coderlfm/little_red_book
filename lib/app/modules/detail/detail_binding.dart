import 'package:get/get.dart';

import 'detail_logic.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailLogic());
  }
}
