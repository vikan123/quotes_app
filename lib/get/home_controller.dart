import 'dart:ffi';

import 'package:get/get.dart';

class HomeController extends GetxController{
  RxBool isDark = false.obs;
  void toggleTheme(){
    isDark.value= !isDark.value;
  }

}