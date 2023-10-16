import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/controllers/auth/forget-password_controller.dart';
import 'package:pharma_man/core/functions/valid.dart';

import 'package:pharma_man/view/widgets/custom_button.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:pharma_man/view/widgets/custom_text_form_auth.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ForgetPass extends StatelessWidget {
  ForgetPassController controller = Get.put(ForgetPassController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body:Obx(() => controller.isLoading.value ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator(color: AppColor.color1,)),
          SizedBox(height: 1.h,),
          CustomText(
            text:'Sending code...',
            color: AppColor.grey,
            size:10.sp,
            wieght:FontWeight.bold, ),
        ],
      ):
       Container(
          padding: EdgeInsets.only(top: 7.h, left: 3.h, right: 3.h),
          child: Form(
            key: controller.formState,
            child: ListView(
              children: [
                Column(
                  children: [
                    CustomText( 
                      text:'Write your correct email please..', 
                      size:15.sp,
                      wieght:FontWeight.normal, 
                      color:AppColor.color2),
                    SizedBox(
                      height: 7.h,
                    ),
                    CustomTextFormAuth(
                      hinttext: 'Enter your email',
                      labeltext: 'Email',
                      iconData: Icons.email_outlined,
                      valid: (val) {
                        return validInput(val!, 5, 45, 'email');
                      },
                      mycontroller: controller.email,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Image.asset(
                      'assets/three32.png',
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    CustomButtom(
                      text: 'Send',
                      color: AppColor.color1,
                  textColor: AppColor.white,
                  width: double.infinity,
                      onPressed: () {
                        controller.sendEmail(controller.email.text);
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
      )
    );
  }
}
