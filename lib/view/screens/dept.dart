import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/const/routes.dart';
import 'package:pharma_man/core/functions/valid.dart';

import 'package:pharma_man/view/widgets/custom_button.dart';
import 'package:pharma_man/view/widgets/custom_icon_button.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:pharma_man/view/widgets/custom_text_button.dart';
import 'package:pharma_man/view/widgets/custom_text_form.dart';
import 'package:pharma_man/view/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/dept_controller.dart';
import '../../model/dept.dart';
import '../widgets/custom_floating_button.dart';

// ignore: must_be_immutable
class DebtScreen extends StatelessWidget {
  DebtScreen({Key? key}) : super(key: key);
  DebtController controller = Get.put(DebtController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        floatingActionButton: CustomFloatingButton(
            onPressed: () {
              Get.defaultDialog(
                  title: 'Enter the info',
                  content: Form(
                    key: controller.formState,
                    child: Column(
                      children: [
                        CustomTextForm(
                          hint: 'Name of customer',
                          icon: Icons.person_outline_outlined,
                          validator: (val) {
                            return validInput(val!, 3, 50, 'username');
                          },
                          mycontroller: controller.name,
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        CustomTextForm(
                          type: TextInputType.number,
                          hint: 'Debt value',
                          icon: Icons.price_change_outlined,
                          validator: (val) {
                            return validInput(val!, 1, 50, '');
                          },
                          mycontroller: controller.value,
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                      ],
                    ),
                  ),
                  confirm: CustomTextButton(
                    text: 'Add',
                    textColor: AppColor.color1,
                    onPressed: () {
                      controller.addDebt(
                        controller.name.text,
                        controller.value.text,
                      );

                      controller.name.clear();
                      controller.value.clear();
                      //  Get.back();
                    },
                  ),
                  cancel: CustomTextButton(
                    text: 'cancel',
                    textColor: AppColor.grey,
                    onPressed: () {
                      controller.name.clear();
                      controller.value.clear();
                      Get.back();
                    },
                  ));
            },
            color: AppColor.color1,
            icon: Icon(Icons.add)),
        body: Container(
          padding: EdgeInsets.all(3.h),
          child: FutureBuilder<AllDebt>(
            future: controller.getAllDebt(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColor.color1,
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData ||
                  snapshot.data?.data?.length == null) {
                return Center(
                  child: CustomText(
                    color: AppColor.white,
                    size: 20.sp,
                    text: 'No debt available',
                    wieght: FontWeight.bold,
                  ),
                );
              } else {
                final allDonations = snapshot.data!.data!;
                return ListView.builder(
                  itemCount: allDonations.length,
                  itemBuilder: (context, index) {
                    final data = allDonations[index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        InkWell(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text(
                                      'Are you sure you want to delete this debt?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Get.back();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final id = data.id.toString();
                                        controller.deleteDebt(id);
                                        Get.back();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Card(
                            color: AppColor.color4,
                            elevation: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.h)),
                              width: double.infinity,
                              height: 25.h,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Icon(
                                          Icons.person_outline_outlined,
                                          color: AppColor.mainColor,
                                          size: 6.h,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        SizedBox(
                                          width: 33.w,
                                          child: CustomText(
                                            text: '${data.customerName}',
                                            size: 20.sp,
                                            wieght: FontWeight.bold,
                                            color: AppColor.black,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        CustomIconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: AppColor.color2,
                                            ),
                                            onPressed: () {
                                              //      final id = data.id.toString();
                                              Get.defaultDialog(
                                                title: 'Enter the info',
                                                content: Column(
                                                  children: [
                                                    CustomTextForm(
                                                      type:
                                                          TextInputType.number,
                                                      hint: 'New debt value',
                                                      icon: Icons
                                                          .price_change_outlined,
                                                      validator: (val) {
                                                        return validInput(
                                                            val!, 1, 50, '');
                                                      },
                                                      mycontroller:
                                                          controller.value,
                                                    ),
                                                    SizedBox(
                                                      height: 1.5.h,
                                                    ),
                                                  ],
                                                ),
                                                confirm: CustomTextButton(
                                                    text: 'Update',
                                                    textColor: AppColor.color1,
                                                    onPressed: () async {
                                                      if (controller
                                                          .value.text.isEmpty) {
                                                        showNotificationSnackbar(
                                                            'Oops!',
                                                            'Did not editing anything');
                                                      } else {
                                                        final id =
                                                            data.id.toString();
                                                        controller.updateDebt(
                                                            controller
                                                                .value.text,
                                                            id);
                                                        print(
                                                            data.id.toString() +
                                                                '' +
                                                                controller.value
                                                                    .text);
                                                        controller.value
                                                            .clear();
                                                      }
                                                    }),
                                                cancel: CustomTextButton(
                                                  text: 'cancel',
                                                  textColor: AppColor.grey,
                                                  onPressed: () {
                                                    controller.value.clear();
                                                    Get.back();
                                                  },
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                    Divider(
                                      thickness: 0.3.h,
                                      color: AppColor.black,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Icon(
                                          Icons.price_change_outlined,
                                          color: AppColor.mainColor,
                                          size: 3.h,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        CustomText(
                                          text: '${data.debtValue}',
                                          size: 15.sp,
                                          wieght: FontWeight.normal,
                                          color: AppColor.grey,
                                          overflow: TextOverflow
                                              .clip, // set overflow to clip
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Icon(
                                          Icons.date_range_outlined,
                                          color: AppColor.mainColor,
                                          size: 3.h,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        CustomText(
                                          text: '${data.debtDate}',
                                          size: 15.sp,
                                          wieght: FontWeight.normal,
                                          color: AppColor.grey,
                                          overflow: TextOverflow
                                              .clip, // set overflow to clip
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
