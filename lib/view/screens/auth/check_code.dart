import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/controllers/auth/check_code_controller.dart';
import 'package:pharma_man/core/functions/valid.dart';
import 'package:pharma_man/view/widgets/custom_button.dart';


import 'package:pharma_man/view/widgets/custom_text_form_auth.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_text.dart';

// ignore: must_be_immutable
class CheckCode extends StatelessWidget {
  CheckCodeController controller = Get.put(CheckCodeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => controller.isLoading.value
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: CircularProgressIndicator(
                  color: AppColor.color1,
                )),
                SizedBox(
                  height: 1.h,
                ),
                CustomText(
                    color:  AppColor.grey,
                    size: 10.sp,
                    text: 'The Password is being reset...',
                    wieght: FontWeight.bold,
                    )
              ],
            )
          : Container(
              padding: EdgeInsets.only(top: 7.h, left: 3.h, right: 3.h),
              child: Form(
                key: controller.formState,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        CustomText(
                          text: 'Enter the code that we had sent to your email',
                          size: 13.sp,                      
                          wieght: FontWeight.normal,  
                            color :AppColor.color2
                            ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomTextFormAuth(
                          hinttext: 'Enter the code',
                          labeltext: 'Code',
                          iconData: Icons.code,
                          mycontroller: controller.code,
                          keyType: TextInputType.number,
                          valid: (val) {
                            return validInput(val!, 6, 6, 'code');
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(
                          thickness: 1.5.h,
                          color: AppColor.color1,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomText(
                          color: AppColor.color2,
                          size: 15.sp,
                          text:'Reset password', 
                          wieght: FontWeight.normal,
                            ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Obx(() {
                          controller.passwordd.value;
                          return CustomTextFormAuth(
                            hinttext: 'Enter new password',
                            labeltext: 'New Password',
                            iconData: Icons.lock_outlined,
                            onChanged: controller.onPasswordChanged,
                            valid: (val) {
                              return validInput(val!, 5, 45, 'password');
                            },
                            mycontroller: controller.password,
                          );
                        }),
                        SizedBox(
                          height: 2.h,
                        ),
                        Obx(() {
                          controller.confirmPassword.value;
                          return CustomTextFormAuth(
                            hinttext: 'Confirm password',
                            labeltext: 'Confirmation',
                            iconData: Icons.lock_outlined,
                            onChanged: controller.onConfirmPasswordChanged,
                            valid: (val) {
                              return controller.validateConfirmPassword();
                            },
                            mycontroller: controller.conPassword,
                          );
                        }),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomButtom(
                          color: AppColor.color1,
                  textColor: AppColor.white,
                  width: double.infinity,
                            onPressed: () {
                              controller.enterCode(
                                controller.code.text,
                                controller.password.text,
                                controller.conPassword.text,
                              );
                            },
                            text: 'Reset')
                      ],
                    )
                  ],
                ),
              )),
    ));
  }
}
