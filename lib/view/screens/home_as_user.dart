import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/best_selling_controller.dart';
import 'package:pharma_man/controllers/drawer_controller.dart';

import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/const/routes.dart';
import 'package:pharma_man/view/widgets/card_items.dart';
import 'package:pharma_man/view/widgets/custom_icon_button.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';

import 'package:sizer/sizer.dart';

import '../../controllers/auth/logout_controlller.dart';
import '../widgets/carousel_items.dart';

// ignore: must_be_immutable
class HomeAsUser extends StatelessWidget {
  final BestSellingController controller = Get.put(BestSellingController());
  DrawController controller2 = Get.put(DrawController());
  LogOutController controller4 = Get.put(LogOutController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller2.key,
      drawer: Drawer(
          width: 70.w,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 20.h,
                child: Center(
                  child: CustomText(
                      text: 'Pharma Care',
                      size: 20.sp,
                      wieght: FontWeight.normal,
                      color: AppColor.white),
                ),
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //     colors: [AppColor.color1, AppColor.color2]),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(5.h)),
                    color: AppColor.color1),
              ),
              SizedBox(
                height: 2.h,
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: CustomText(
                    text: 'Add Supplier',
                    size: 12.sp,
                    wieght: FontWeight.bold,
                    color: AppColor.black),
                onTap: () {
                  Get.toNamed(AppRoute.postSuppliersScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.supervisor_account_outlined),
                title: CustomText(
                    text: 'All Suppliers',
                    size: 12.sp,
                    wieght: FontWeight.bold,
                    color: AppColor.black),
                onTap: () {
                  Get.toNamed(AppRoute.allsuppliers);
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.add),
              //   title: CustomText(
              //       text: 'Add Employee',
              //       size: 12.sp,
              //       wieght: FontWeight.bold,
              //       color: AppColor.black),
              //   onTap: () {
              //     Get.toNamed(AppRoute.addEmploye);
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.supervisor_account_outlined),
                title: CustomText(
                    text: 'All Employees',
                    size: 12.sp,
                    wieght: FontWeight.bold,
                    color: AppColor.black),
                onTap: () {
                  Get.toNamed(AppRoute.allEmployees);
                },
              ),
              ListTile(
                leading: Icon(Icons.data_array),
                title: CustomText(
                    text: 'expired products',
                    size: 12.sp,
                    wieght: FontWeight.bold,
                    color: AppColor.black),
                onTap: () => Get.toNamed(AppRoute.expiredProduct),
              ),
              ListTile(
                leading: Icon(Icons.data_object),
                title: CustomText(
                    text: 'outstock products',
                    size: 12.sp,
                    wieght: FontWeight.bold,
                    color: AppColor.black),
                onTap: () => Get.toNamed(AppRoute.outstockProduct),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: CustomText(
                    text: 'logOut',
                    size: 12.sp,
                    wieght: FontWeight.bold,
                    color: AppColor.black),
                onTap: () {
                  print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text('Are you sure ?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              controller4.logOut();
                              Get.back();
                            },
                            child: const Text('logOut'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          )),
      backgroundColor: AppColor.white,
      body: Column(children: [
        Stack(
          children: [
            Container(
              height: 21.h,
              // MediaQuery.of(context).size.height-590,
              width: double.infinity,
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //       colors: [AppColor.color1, AppColor.color2]),
                color: AppColor.color1,
                borderRadius: BorderRadius.only(
                  // bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(10.h),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                            icon: Icon(
                              Icons.menu_sharp,
                              color: AppColor.white,
                              size: 4.h,
                            ),
                            onPressed: () {
                              controller2.openDrawer();
                            }),
                        SizedBox(
                          height: 7.h,
                          width: 70.w,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: CustomText(
                      overflow: TextOverflow.clip,
                      text: 'Pharma_Care',
                      fontFamily: 'Pacifico',
                      size: 27.sp,
                      color: AppColor.white,
                      wieght: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -10,
              right: 30,
              child: Stack(
                children: [],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CarouselSliderItems(),
        const SizedBox(
          height: 20,
        ),
        CardItems(),
      ]),
    );
  }
}
