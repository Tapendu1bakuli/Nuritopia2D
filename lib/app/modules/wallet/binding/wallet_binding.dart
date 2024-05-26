import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';


import '../controller/wallet_controller.dart';

class WalletBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(
          () => WalletController(),
    );
  }

}