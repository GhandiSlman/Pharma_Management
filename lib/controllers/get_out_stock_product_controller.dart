
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart'as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_man/model/out_stock_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/const/api.dart';
class OutStockProductController extends GetxController {
var outProductList = <OutStockProduct>[].obs;
  var isLoading = true.obs;
  RxString title = ''.obs;
  @override
  onInit() {
    getOutProducts();
    super.onInit();
  }

   static Future<List<OutStockProduct>> getOutProduct() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? token = sh.getString('signup');

    var url = Uri.parse('${Api}p_outstock');
    print(token);
    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      var jsonData = response.body;
     return outStockProductFromJson(jsonData);
    } else {
      return throw Exception("Failed to load product");
    }
  }

  Future getOutProducts() async {
    try {
      isLoading.value = true;
      // Check for internet connection
      var isConnected = await InternetConnectionChecker().hasConnection;

      if (!isConnected) {
        Get.snackbar(
          'No internet connection',
          'Please check your internet connection and try again.',
          backgroundColor: Color.fromARGB(255, 245, 113, 103),
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading.value = false;
        return;
      }
      var product = await getOutProduct();

      if (product.isNotEmpty) {
        outProductList.addAll(product);
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }


  
}
