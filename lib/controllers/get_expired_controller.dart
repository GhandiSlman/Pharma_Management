import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_man/core/const/api.dart';
import 'package:pharma_man/model/expired_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class ExpiredProductController extends GetxController {



var expiredProductList = <ExpiredProduct>[].obs;
  var isLoading = true.obs;
  RxString title = ''.obs;
  @override
  onInit() {
    getExpiredProducts();
    super.onInit();
  }

   Future<List<ExpiredProduct>> getExpiredProduct() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? token = sh.getString('signup');

    var url = Uri.parse('${Api}p_expired');
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
     return expiredProductFromJson(jsonData);
    } else {
      return throw Exception("Failed to load product");
    }
  }

  Future getExpiredProducts() async {
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
      var product = await getExpiredProduct();

      if (product.isNotEmpty) {
        expiredProductList.addAll(product);
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }


  
}
