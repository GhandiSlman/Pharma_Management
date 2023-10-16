import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharma_man/model/categories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../core/const/api.dart';

class Catergores extends GetxController {
  RxInt? id = 0.obs;

  @override
  onInit() {
    super.onInit();
    getCategories();
  }

  Future getCategories() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      final url = Uri.parse('${Api}Get-Gategorie');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = response.body;
        return categoriesFromJson(jsonData);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Color.fromARGB(255, 245, 113, 103),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
