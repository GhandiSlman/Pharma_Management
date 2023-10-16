import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharma_man/model/suppliers.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../core/const/api.dart';
class SuppliersCotroller extends GetxController {
  RxInt? id = 0.obs;

  @override
  onInit() {
    super.onInit();
    getSuppliers();
  }

  Future getSuppliers() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print('token${token}');

      final url = Uri.parse('${Api}suppliers');
      //print('token${token}');
      print('GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGgg');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('${response.headers}rafat');
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);

        var jsonData = response.body;
        print('rami${response.body}');

        return suppliersFromJson(jsonData);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Color.fromARGB(255, 245, 113, 103),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
