import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/controllers/auth/login_controller.dart';
import 'package:pharma_man/core/functions/valid.dart';
import 'package:pharma_man/view/widgets/custom_button.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:pharma_man/view/widgets/custom_text_button.dart';
import 'package:pharma_man/view/widgets/custom_text_form_auth.dart';
import 'package:sizer/sizer.dart';



// ignore: must_be_immutable
class Login extends StatelessWidget {
  LoginController controller = Get.put(LoginController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Obx(() => controller.isLoading.value ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator(color: AppColor.color1,)),
          SizedBox(height: 1.h,),
          CustomText(text:'Loging in...', size:10.sp,wieght: FontWeight.bold,color: AppColor.grey)
        ],
      ):
       Container(
        padding: EdgeInsets.only(left: 3.h, right: 3.h),
        child: Form(
          key: controller.formState,
          child: ListView(children: [
            Column(
              children: [
                Image.asset('assets/three3.png'),
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
                GetBuilder<LoginController>(builder: (controller) {
                  return CustomTextFormAuth(
                    obscuretext: controller.isshowpass,
                    hinttext: 'Enter your password',
                    labeltext: 'password',
                    iconData: Icons.remove_red_eye_outlined,
                    mycontroller: controller.password,
                    valid: (val) {
                      return validInput(val!, 5, 45, 'password');
                    },
                    ontapicon: () => controller.isShowPass(),
                  );
                }),
                TextButton(
                  onPressed: () {
                     controller.goToForgetPass();
                   // Get.offNamed(AppRoute.forgetPass);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 28.h),
                    child: CustomText(text:'Forget Password ?',size: 10.sp,
                       wieght: FontWeight.bold, color: AppColor.color2),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomButtom(
                  text: 'Sign In',
                  color: AppColor.color1,
                  textColor: AppColor.white,
                  width: double.infinity,
                  onPressed: () {
                    controller.login(
                        controller.email.text, controller.password.text);
                  },
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1.h,
                    ),
                    CustomText(text:"You don't have an account ?", size:11.sp,
                       wieght: FontWeight.normal, color:AppColor.grey),
                    CustomTextButton(
                        textColor: AppColor.color1,
                        onPressed: () {
                          controller.goToSignUp();
                        },
                        text: 'Sign Up')
                  ],
                ),
              ],
            ),
          ]
          ),
        ),
      ),
      )
    );
  }
}
