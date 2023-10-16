import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_man/view/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/const/api.dart';

class AddInvoiceController extends GetxController {
  GlobalKey<FormState> formState1 = GlobalKey<FormState>();
  late final TextEditingController nameCustomer;

  final RxString scanResult = RxString('');
  RxBool isLoading = false.obs;

  Future<void> addinvoice(
    String nameCustomer,
    String quantity,
    String id,
    String quantity1,
    String id1,
  ) async {
    try {
      var formdata = formState1.currentState;
      if (formdata!.validate()) {
        SharedPreferences sh = await SharedPreferences.getInstance();
        String? token = sh.getString('signup');
        var isConnected = await InternetConnectionChecker().hasConnection;
        if (!isConnected) {
          isLoading.value = true;
          Get.snackbar(
            'No internet connection',
            'Please check your internet connection and try again.',
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          isLoading.value = false;
        }

        var headers = <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

        var response = await http.post(Uri.parse('${Api}store'),
            headers: headers,
            body: <String, String>{
              'customer_name': nameCustomer,
              'products[0][product_id]': id,
              'products[0][quantity]': quantity,
              'products[1][product_id]': id1,
              'products[1][quantity]': quantity1,

            });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          showNotificationSnackbar('Hi', 'invoice added');
          // ignore: unused_local_variable
          if (response.body.isNotEmpty) {
  // ignore: unused_local_variable
  var responseBody = jsonDecode(response.body);
  
} else {
  print("The response body is empty.");

}
          
          isLoading.value = false;
        } else if(response.statusCode == 404){
          print(response.statusCode);
          isLoading.value = true;
          Get.snackbar(
            'Error',
            'Something went wrong',
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
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

  @override
  void onInit(){
    nameCustomer = TextEditingController();
    super.onInit();
  }
}
