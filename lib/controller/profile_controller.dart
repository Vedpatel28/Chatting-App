import 'dart:developer';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool showPassword = false.obs;

  changeShow() {
    showPassword(!showPassword.value);
    log("$showPassword");

    update();
  }
}
