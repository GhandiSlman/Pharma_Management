import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawController extends GetxController {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  void openDrawer() {
    key.currentState!.openDrawer();
  }
}
