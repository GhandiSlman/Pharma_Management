import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/employee_controller.dart';
import 'package:sizer/sizer.dart';
import '../../core/const/appcolor.dart';
import '../../core/functions/valid.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form.dart';

// ignore: must_be_immutable
class AddEmploye extends StatelessWidget {
  AddEmploye({Key? key}) : super(key: key);

  EmployeeController controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'Add employee',
          ),
          body: Form(
            key: controller.formState,
            child: Padding(
              padding: EdgeInsets.all(3.h),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 7.h,
                      ),
                      CustomTextForm(
                          mycontroller: controller.name,
                          validator: (val) {
                            return validInput(val!, 3, 50, 'username');
                          },
                          hint: 'Name',
                          icon: Icons.person_outlined),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      CustomTextForm(
                          mycontroller: controller.email,
                          type: TextInputType.emailAddress,
                          validator: (val) {
                            return validInput(val!, 3, 50, 'email');
                          },
                          hint: 'Email',
                          icon: Icons.email_outlined),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      CustomTextForm(
                          mycontroller: controller.password,
                          validator: (val) {
                            return validInput(val!, 8, 50, '');
                          },
                          hint: 'Password',
                          icon: Icons.password_outlined),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      CustomTextForm(
                          mycontroller: controller.BirthDate,
                          type: TextInputType.datetime,
                          validator: (val) {
                            return validInput(val!, 8, 50, '');
                          },
                          hint: 'Birth date',
                          icon: Icons.date_range_outlined),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 41.w,
                            child: CustomTextForm(
                              type: TextInputType.number,
                                mycontroller: controller.phone,
                                validator: (val) {
                                  return validInput(val!, 3, 50, '');
                                },
                                hint: 'Phone',
                                icon: Icons.format_list_numbered_outlined),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          SizedBox(
                              width: 41.w,
                              child: CustomTextForm(
                                type: TextInputType.number,
                                mycontroller: controller.salary,
                                validator: (val) {
                                  return validInput(val!, 3, 50, '');
                                },
                                hint: 'Salary',
                                icon: Icons.money_outlined,
                              )),
                          // SizedBox(
//   width: 1.4.w,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 41.w,
                        child: CustomTextForm(
                          type: TextInputType.datetime,
                            mycontroller: controller.dateStart,
                            validator: (val) {
                              return validInput(val!, 3, 50, '');
                            },
                            hint: 'Date start work',
                            icon: Icons.date_range_outlined),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButtom(
                          text: 'Add employee',
                          onPressed: () {
                            controller.addEmployee(
                                controller.name.text,
                                controller.email.text,
                                controller.password.text,
                                controller.BirthDate.text,
                                controller.phone.text,
                                controller.salary.text,
                                controller.dateStart.text
                                
                                );
                          },
                          gradient: LinearGradient(
                              colors: [AppColor.color1, AppColor.color2],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                          textColor: AppColor.white,
                          width: double.infinity),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
