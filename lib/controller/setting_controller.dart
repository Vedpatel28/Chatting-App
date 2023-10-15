// ignore_for_file: unrelated_type_equality_checks, camel_case_types

import 'package:chat_app_firebase/modal/setting_modal.dart';
import 'package:get/get.dart';

class settingController extends GetxController {

  settingmodel models = settingmodel();

  changeTheme() {
    models.theme.value = !models.theme.value;
  }
}