import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/controllers/auth/signup_controller.dart';
import 'package:pharma_man/core/functions/valid.dart';
import 'package:pharma_man/view/widgets/custom_button.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:pharma_man/view/widgets/custom_text_button.dart';
import 'package:pharma_man/view/widgets/custom_text_form_auth.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  var controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Obx(() => controller.isLoading.value ?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator(color: AppColor.color1,)),
          SizedBox(height: 1.h,),
          CustomText(text:'Signing up...', size:10.sp, wieght:FontWeight.bold,color: AppColor.grey)
        ],
      ):
      Container(
        padding: EdgeInsets.only(
          top: 7.h,
          left: 3.h,
          right: 3.h,
        ),
        child: Form(
          key: controller.formState,
          child: ListView(children: [
            Column(
              children: [
                CustomText(text: 'Sign Up', size: 20.sp, wieght: FontWeight.bold, color: AppColor.color2),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFormAuth(
                  hinttext: 'Enter your name',
                  labeltext: 'User Name',
                  iconData: Icons.person_2_outlined,
                  mycontroller: controller.name,
                  valid: (val) {
                    return validInput(val!, 3, 45, 'username');
                  },
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextFormAuth(
                  hinttext: 'Enter your email',
                  labeltext: 'Email',
                  iconData: Icons.email_outlined,
                  mycontroller: controller.email,
                  valid: (val) {
                    return validInput(val!, 5, 45, 'email');
                  },
                ),
                SizedBox(
                  height: 1.h,
                ),
                Obx(() {
                  controller.passwordd.value;
                  return CustomTextFormAuth(
                    hinttext: 'Enter your password',
                    labeltext: 'Password',
                    iconData: Icons.lock_outline_rounded,
                    mycontroller: controller.password,
                    onChanged: controller.onPasswordChanged,
                    valid: (val) {
                      return validInput(val!, 5, 45, 'password');
                    },
                  );
                }),
                SizedBox(
                  height: 1.h,
                ),
                Obx(() {
                  controller.confirmPassword.value;
                  return CustomTextFormAuth(
                    hinttext: 'Confim password',
                    labeltext: 'Confirmation',
                    iconData: Icons.lock_outline_rounded,
                    mycontroller: controller.conPassword,
                    onChanged: controller.onConfirmPasswordChanged,
                    valid: (val) {
                      return controller.validateConfirmPassword(val!);
                    },
                  );
                }),
                  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              
                              Obx(() => CustomButtom(
                                    text: 'As admin',
                                   
                                    textColor: AppColor.white,
                                    width: 20.w,
onPressed: () {
                                      controller.setUserType('admin');  
                                      print(controller.userType);
                                    },
                                    color: controller.userType.value =='admin' ? AppColor.mainColor : AppColor.mainColor,
                                  )),
                                  Obx(() => CustomButtom(
                                    text: 'As user',
                                    textColor: AppColor.white,
                                    width: 20.w,
                                    onPressed: () {
                                      controller.setUserType('user');  
                                      print(controller.userType);
                                    },
                                    color: controller.userType.value =='user' ? AppColor.mainColor : AppColor.mainColor,
                                  )),
                            ],
                          ),
                SizedBox( 
                  height: 5.h,
                ),
                CustomButtom(
                  text: 'Sign Up',
                  color: AppColor.color1,
                  textColor: AppColor.white,
                  width: double.infinity,
                  onPressed: () {
                    controller.signUp(
                      controller.name.text,
                      controller.email.text,
                      controller.password.text,
                      controller.conPassword.text
                    );
                  },
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1.w,
                    ),
                    CustomText(text: 'Have an account ?', size: 11.sp, wieght: FontWeight.normal,
                       color:AppColor.grey),
                    CustomTextButton(
                      text: 'Sign In',
                      textColor: AppColor.color1,
                      onPressed: () {
                        controller.goToSignIn();
                      },
                    ),
                  ],
                ),
              ],
            )
          ]),
        ),
      ),
     )
    );
  }
}
