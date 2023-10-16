import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/update_suppliers_contoller.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/functions/valid.dart';
import 'package:pharma_man/view/widgets/custom_app_bar.dart';
import 'package:pharma_man/view/widgets/custom_button.dart';
import 'package:pharma_man/view/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form.dart';

// ignore: must_be_immutable
class EditSupplier extends StatelessWidget {
  EditSuppliersController controller = Get.put(EditSuppliersController());
  final String supplierId = Get.arguments as String;
  EditSupplier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
              title: 'Edit Supplier',
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
                : SingleChildScrollView(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomTextForm(
                            hint: 'Name',
                            icon: Icons.person,
                            mycontroller: controller.name,
                          ),
                          SizedBox(height: 3.h),
                          CustomTextForm(
                            hint: 'Phone',
                            type: TextInputType.number,
                            icon: Icons.phone,
                            mycontroller: controller.phone,
                          ),
                          SizedBox(height: 3.h),
                          CustomTextForm(
                            hint: 'Company',
                            icon: Icons.business,
                            mycontroller: controller.company,
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextForm(
                                  hint: 'Address',
                                  icon: Icons.location_on,
                                  mycontroller: controller.address,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: CustomTextForm(
                                  hint: 'Email',
                                  type: TextInputType.emailAddress,
                                  icon: Icons.email,
                                  mycontroller: controller.email,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          CustomTextForm(
                            hint: 'Description',
                            icon: Icons.description,
                            mycontroller: controller.description,
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 8.h,
                            width: 70.w,
                            child: CustomButtom(
                              text: 'Done',
                              textColor: AppColor.white,
                              gradient: LinearGradient(
                                  colors: [
                                    AppColor.color1,
                                    AppColor.color2,
                                    AppColor.color3
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                              onPressed: () async {
                                if (controller.name.text.isEmpty &&
                                    controller.phone.text.isEmpty &&
                                    controller.address.text.isEmpty &&
                                    controller.company.text.isEmpty &&
                                    controller.description.text.isEmpty &&
                                    controller.email.text.isEmpty) {
                                  showNotificationSnackbar('Oops!', 'Did not editing anything');
                                }else
                                await controller.editSuppliers(
                                  controller.name.text,
                                  controller.phone.text,
                                  controller.address.text,
                                  controller.company.text,
                                  controller.description.text,
                                  controller.email.text,
                                  supplierId.toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))));
  }
}
