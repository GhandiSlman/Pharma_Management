import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pharma_man/controllers/auth/signup_controller.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/controllers/auth/login_controller.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/main_controller.dart';


// ignore: must_be_immutable
class MainScreenAsUser extends StatelessWidget {
  MainScreenAsUser({Key? key}) : super(key: key);
  MainController controller = Get.put(MainController());
  LoginController controller2 = Get.put(LoginController());
  SignUpController controller3 = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.white,
      body: Obx(
        () =>
             controller.pages2[controller.selectedIndex.value]
           
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(1.5.h),
        child: Container(
          padding: EdgeInsets.all(1.5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.h),
            color: AppColor.color1,
          ),
          child: 
               GNav(
                  backgroundColor: AppColor.color1,
                  color: AppColor.white,
                  activeColor: AppColor.white,
                  tabBackgroundColor: AppColor.white,
                  padding: EdgeInsets.all(0.5.h),
                  selectedIndex: controller.selectedIndex.value,
                  onTabChange: (selectedIndex) {
                    controller.selectedIndex.value = selectedIndex;
                  },
                  gap: 10,
                  tabs: [
                      GButton(
                        icon: Icons.home_outlined,
                        text: 'Home',
                        textColor: AppColor.color1,
                        iconActiveColor: AppColor.color1,
                      ),
                      GButton(
                        icon: Icons.local_offer_outlined,
                        text: 'Sales',
                        textColor: AppColor.color1,
                        iconActiveColor: AppColor.color1,
                      ),
                      GButton(
                        icon: Icons.insert_invitation_outlined,
                        text: 'Invoices',
                        textColor: AppColor.color1,
                        iconActiveColor: AppColor.color1,
                      ),
                      
                    ])
             
        ),
      ),
    ));
  }
}
