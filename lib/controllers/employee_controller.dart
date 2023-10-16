import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pharma_man/core/const/api.dart';
import 'package:pharma_man/core/const/routes.dart';
import 'package:pharma_man/model/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class EmployeeController extends GetxController {
  var isLoading = true.obs;
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController BirthDate;
  late final TextEditingController phone;
  late final TextEditingController salary;
  late final TextEditingController dateStart;
  var employeeList = Employee(data: []).obs;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    BirthDate = TextEditingController();
    phone = TextEditingController();
    salary = TextEditingController();
    dateStart = TextEditingController();
    fetchEmployee();
  }

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future<void> fetchEmployee() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString('signup');

      var response = await http.get(
        Uri.parse('${Api}employees'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var employees = employeeFromJson(response.body);
        employeeList.value = employees;
        print(response.body);
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

  Future addEmployee(String name,String email, String password,String birthDate,String phone,String salary , String dateStart) async {
    try {
      var formdata = formState.currentState;
      if (formdata!.validate()) {
        SharedPreferences sh = await SharedPreferences.getInstance();
        String? token = sh.getString('signup');
        isLoading.value = true;
        // Check for internet connection
        var isConnected = await InternetConnectionChecker().hasConnection;

        if (!isConnected) {
          // Handle no internet connection
          isLoading.value = false;
          Get.snackbar(
            'No internet connection',
            'Please check your internet connection and try again.',
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
        var headers = <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
        // Internet connection available, proceed with login
        isLoading.value = true;
        var response = await http.post(
          Uri.parse('${Api}add-employee'),
          body: <String, String>{
            'name': name,
            'email':email,
            'password':password,
            'birthdate':birthDate,
            'phone':phone,
            'salary':salary,
            'start_date':dateStart
          },
          headers: headers,
        );
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
           Get.offNamed(AppRoute.allEmployees);
          isLoading.value = true;
          fetchEmployee();
          isLoading.value = false;
          // Get.snackbar('Success', 'Done',
          //     padding: const EdgeInsets.all(10),
//     backgroundColor: Colors.green,
          //     snackPosition: SnackPosition.TOP);
        } else {
          isLoading.value = false;
          // Handle login failure
          Get.snackbar(
            'error',
            'some thing went wrong',
            padding: EdgeInsets.all(2.h),
            backgroundColor: Color.fromARGB(255, 245, 113, 103),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      print(e);
    }
  }
}
