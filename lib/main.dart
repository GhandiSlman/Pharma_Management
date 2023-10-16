import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/routes.dart';
import 'package:pharma_man/view/screens/auth/login.dart';
import 'package:pharma_man/view/screens/main_sceeen_as_user.dart';
import 'package:pharma_man/view/screens/main_screen_as_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


late SharedPreferences sh;
void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  sh = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      String token = sh.getString('signup') ?? '';
      String userType = sh.getString('type') ?? '';
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        
        getPages: routes, 
          home: token.isEmpty
            ? Login()
            : (userType == 'admin' ? MainScreenAsAdmin() : MainScreenAsUser()),
      );
    });
  }
}
