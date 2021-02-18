import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void navigateTo(Widget page) {
    Get.to(() => page, transition: Transition.downToUp);
  }

  static void openDialog(Widget page, {bool dismissable = false}) {
    Get.dialog(page, barrierDismissible: dismissable, useSafeArea: true);
  }
}