import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pharma_man/core/const/api.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/model/purchase.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllPurchaseController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
 
  RxBool isLoading = true.obs;

  @override
  onInit() {
    super.onInit();
    getPurchase();
  }

  Future getPurchase() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print('token${token}');

      final url = Uri.parse('${Api}purchases');
      print('token${token}');
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
        isLoading.value = false;
        return purchasesFromJson(jsonData);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "error",
        e.toString(),
        animationDuration: Duration(seconds: 3),
        instantInit: false,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.black.withOpacity(0.3),
        borderRadius: 80,
        borderWidth: 0.9,
        borderColor: AppColor.red.withBlue(1),
        margin: EdgeInsets.symmetric(vertical: 50),
        titleText: Center(
          child: Text(
            'error',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        messageText: Center(
            child: Text(
          e.toString(),
          style: TextStyle(color: AppColor.white),
        )),
        snackStyle: SnackStyle.FLOATING,
        padding: EdgeInsets.only(bottom: 0.4),
      );
    }
  }

  Future<void> deletePurchase(int id) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print('token${token}');

      final url = Uri.parse('${Api}delete-purchases/$id');
      print('token${token}');
      var response = await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('${response.headers}rafat');
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        
        
        isLoading.value = true;
        await getPurchase();
        isLoading.value = false;

        print('Deleted purchase with ID: $id');
      } else {
        throw Exception('Failed to delete purchase');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "error",
        e.toString(),
        animationDuration: Duration(seconds: 3),
        instantInit: false,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.black.withOpacity(0.3),
        borderRadius: 80,
        borderWidth: 0.9,
        borderColor: AppColor.red.withBlue(1),
        margin: EdgeInsets.symmetric(vertical: 50),
        titleText: Center(
          child: Text(
            'error',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        messageText: Center(
          child: Text(
            e.toString(),
            style: TextStyle(color: AppColor.white),
          ),
        ),
        snackStyle: SnackStyle.FLOATING,
        padding: EdgeInsets.only(bottom: 0.4),
      );
    }
  }
}
