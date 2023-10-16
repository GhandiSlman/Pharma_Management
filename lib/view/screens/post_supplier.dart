import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/functions/valid.dart';
import 'package:pharma_man/view/widgets/custom_app_bar.dart';
import 'package:pharma_man/view/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/post_supplier_controller.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form.dart';

// ignore: must_be_immutable
class PostSuppliersScreen extends StatelessWidget {
  PostSupplierController controller =
      Get.put(PostSupplierController(), permanent: true);
  PostSuppliersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
              title: 'Add Supplier',
            ),
            body: Obx(() => controller.isLoading.value
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
                          text: 'Adding...',
                          size: 10.sp,
                          wieght: FontWeight.bold,
                          color: AppColor.grey)
                    ],
                  )
                : Container(
                    padding: EdgeInsets.all(3.h),
                    child: Form(
                        key: controller.formState,
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Column(
                                  children: [
                                    CustomTextForm(
                                      hint: 'Name',
                                      icon: Icons.person_outlined,
                                      mycontroller: controller.name,
                                      validator: (val) {
                                        return validInput(
                                            val!, 3, 50, 'username');
                                      },
                                    ),
                                    SizedBox(height: 1.5.h),
                                    CustomTextForm(
                                      hint: 'Phone',
                                      type: TextInputType.number,
                                      icon: Icons.phone_enabled_outlined,
                                      mycontroller: controller.phone,
                                      validator: (val) {
                                        return validInput(val!, 3, 50, '');
                                      },
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    CustomTextForm(
                                      hint: 'Company',
                                      icon: Icons.home_work_outlined,
                                      mycontroller: controller.company,
                                      validator: (val) {
                                        return validInput(val!, 3, 50, '');
                                      },
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    CustomText(
                                        text: 'Add this info if you want : ',
                                        size: 15.sp,
                                        wieght: FontWeight.normal,
                                        color: AppColor.grey),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 41.w,
                                          child: CustomTextForm(
                                            hint: 'Address',
                                            icon: Icons.location_city_outlined,
                                            mycontroller: controller.address,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        SizedBox(
                                          width: 41.w,
                                          child: CustomTextForm(
                                              hint: 'Email',
                                              type: TextInputType.emailAddress,
                                              icon: Icons.email_outlined,
                                              mycontroller: controller.email,
                                              validator: (val) {
                                                if (val!.isNotEmpty &&
                                                    !(val.contains('@'))) {
                                                  return 'Invalid email';
                                                }
                                                return null;
                                              }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    SizedBox(
                                      width: 41.w,
                                      child: CustomTextForm(
                                        hint: 'Description',
                                        icon: Icons.description_outlined,
                                        mycontroller: controller.desc,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    CustomButtom(
                                      text: 'Done',
                                      gradient: LinearGradient(
                                          colors: [
                                            AppColor.color1,
                                            AppColor.color2,
                                            AppColor.color3
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                      onPressed: () async {
                                        if (controller.formState.currentState
                                                ?.validate() ??
                                            false) {
                                          // ignore: unused_local_variable
                                          bool success = await controller.add(
                                              controller.name.text,
                                              controller.email.text,
                                              controller.phone.text,
                                              controller.address.text,
                                              controller.company.text,
                                              controller.desc.text);
                                          
                                        }
                                      },
                                      textColor: AppColor.white,
                                      width: 50.h,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )),
                  ))));
  }
}
