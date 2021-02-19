import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void navigateTo(Widget page) {
    Get.to(() => page, transition: Transition.downToUp);
  }

  static Future<void> openDialog(Widget page, {bool dismissable = false}) async {
    return await Get.dialog(page, barrierDismissible: dismissable, );
  }
}