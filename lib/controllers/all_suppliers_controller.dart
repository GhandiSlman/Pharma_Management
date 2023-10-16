import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharma_man/core/const/api.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/model/suppliers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllSuppliersController extends GetxController {
  var isLoading = true.obs;
  var suppliersList = Suppliers(data: []).obs;

  @override
  void onInit() {
    super.onInit();
    fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print('token${token}');

      var response = await http.get(
        Uri.parse('${Api}suppliers'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var suppliers = suppliersFromJson(response.body);
        suppliersList.value = suppliers;
      } else {
        print('server error');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Color.fromARGB(255, 245, 113, 103),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSuppliers(int id) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');
      print('token${token}');

      final url = Uri.parse('${Api}Delete-suppliers/$id');
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
        await fetchSuppliers();
        isLoading.value = false;

        print('Deleted purchase with ID: $id');
      } else {
        throw Exception('Failed to delete supplier');
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
            style: TextStyle(color: AppColor.white, fontSize: 15),
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
