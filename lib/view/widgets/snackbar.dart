import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharma_man/core/const/appcolor.dart';

void showNotificationSnackbar(String title, String message) {
  Get.snackbar(
    title, 
    message, 
    titleText: Text(
      title,
      style: TextStyle(fontSize: 20, color: Colors.white), 
    ),
    messageText: Text(
      message,
      style: TextStyle(fontSize: 16, color: Colors.white), 
    ),
    snackPosition: SnackPosition.TOP, 
    backgroundColor: AppColor.color1,
    colorText: Colors.white,
    icon: Icon(Icons.notifications, color: Colors.red, size: 30),
    isDismissible: true,
    duration: Duration(seconds: 2),
    overlayBlur: 0.5,
    overlayColor: Colors.grey.withOpacity(0.3),
    margin: EdgeInsets.all(10),
    borderRadius: 10,
  );
}
