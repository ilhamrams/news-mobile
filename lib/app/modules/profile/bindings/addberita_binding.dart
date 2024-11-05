import 'package:get/get.dart';
import '../controllers/addberita_controller.dart';

class AddberitaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBerita>(() => AddBerita());
  }
}
