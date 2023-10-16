import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/employee_controller.dart';
import 'package:pharma_man/view/widgets/custom_InfoRow.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../../core/const/appcolor.dart';

class CardEmployee extends StatelessWidget {
  final EmployeeController controller = Get.put(EmployeeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.employeeList.value.data.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 45.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  text: '',
                  size: 30,
                  color: AppColor.mainColor,
                  wieght: FontWeight.w700,
                  fontFamily: 'Pacifico',
                ),
              ),
            ],
          ),
        );
      } else if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: 130),
          child: Center(
            child: CircularProgressIndicator(
              color: AppColor.color1,
            ),
          ),
        );
      } else {
        return Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return Column(
                  children: [
                    
                    SizedBox(height: 5.h
                    ,),
                  ],
                );
              },
              itemCount: controller.employeeList.value.data.length,
              // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //   childAspectRatio: 1.0,
              //   maxCrossAxisExtent: MediaQuery.of(context).size.width,
              // ),
              itemBuilder: (context, index) {
                return Card(
                  color: AppColor.color4,
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.mainColor,
                              child: Icon(Icons.account_circle,
                                  size: 40, color: Colors.white),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: controller.employeeList.value
                                          .data[index].attributes.name
                                          .toString(),
                                      size: 20,
                                      wieght: FontWeight.bold,
                                      color: AppColor.black),
                                  CustomText(
                                      text: 'Trainee pharmacist',
                                      size: 15,
                                      wieght: FontWeight.normal,
                                      color: AppColor.grey),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: AppColor.grey, thickness: 0.3),
                        InfoRow(
                          icon: Icons.email_outlined,
                          info: controller
                              .employeeList.value.data[index].attributes.email
                              .toString(),
                        ),
                        InfoRow(
                          icon: Icons.phone_outlined,
                          info: controller
                              .employeeList.value.data[index].attributes.phone
                              .toString(),
                        ),
                        InfoRow(
                          icon: Icons.calendar_today_outlined,
                          info: controller.employeeList.value.data[index]
                              .attributes.birthdate
                              .toString()
                              .substring(0, 10),
                        ),
                        InfoRow(
                          icon: Icons.date_range_outlined,
                          info: controller.employeeList.value.data[index]
                              .attributes.startDate
                              .toString()
                              .substring(0, 10),
                        ),
                        InfoRow(
                          icon: Icons.money_outlined,
                          info: controller.employeeList.value.data[index]
                                  .attributes.salary
                                  .toString() +
                              ' \$',
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      }
    });
  }
}
