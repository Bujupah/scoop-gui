import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void navigateTo(BuildContext context, Widget pathTo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pathTo),
    );
  }
}