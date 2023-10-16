import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pharma_man/controllers/all_suppliers_controller.dart';
import 'package:pharma_man/controllers/auth/signup_controller.dart';
import 'package:pharma_man/core/const/routes.dart';

import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/const/appcolor.dart';
import 'custom_InfoRow.dart';

class CardSupliers extends StatelessWidget {
  // SignUpController controller2 = Get.find();

  final AllSuppliersController controller = Get.put(AllSuppliersController());
  final SignUpController controller2 = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.suppliersList.value.data.isEmpty) {
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
            child: GridView.builder(
                itemCount: controller.suppliersList.value.data.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 1.1,
                  maxCrossAxisExtent: MediaQuery.of(context).size.width,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () async {
                      SharedPreferences sh =
                          await SharedPreferences.getInstance();
                      String? userType = sh.getString('type');
                      userType == 'admin'
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text(
                                      'Are you sure you want to delete this supplier?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await controller.deleteSuppliers(
                                          controller.suppliersList.value
                                              .data[index].attributes.id
                                              .toInt(),
                                        );
                                        Get.back();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            )
                          : print('-------------');
                    },
                    child: Card(
                      elevation: 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                Icon(Icons.account_circle,
                                    size: 40, color: AppColor.mainColor),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: controller.suppliersList.value
                                              .data[index].attributes.name
                                              .toString(),
                                          size: 20,
                                          wieght: FontWeight.bold,
                                          color: AppColor.black),
                                      CustomText(
                                          text: '  ' +
                                              controller
                                                  .suppliersList
                                                  .value
                                                  .data[index]
                                                  .attributes
                                                  .company
                                                  .toString(),
                                          size: 15,
                                          wieght: FontWeight.normal,
                                          color: AppColor.grey),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      String purchaseId = controller
                                          .suppliersList
                                          .value
                                          .data[index]
                                          .attributes
                                          .id
                                          .toString();
                                      print(
                                          'tare=${controller.suppliersList.value.data[index].attributes.id}');
                                      SharedPreferences sh =
                                          await SharedPreferences.getInstance();
                                      var type = sh.getString('type');
                                      type == 'admin'
                                          ? Get.offNamed(
                                              AppRoute.editSupplier,
                                              arguments: purchaseId,
                                            )
                                          : Get.defaultDialog(
                                              title: 'Warning!',
                                              content: Text(
                                                  'You can not edit..you are user'));
                                    },
                                    icon: Icon(Icons.edit))
                              ],
                            ),
                            Divider(color: AppColor.grey, thickness: 0.3),
                            InfoRow(
                              icon: Icons.email,
                              info: controller.suppliersList.value.data[index]
                                  .attributes.email!.isEmpty?'No email': 
                                  controller.suppliersList.value.data[index]
                                  .attributes.email
                                  .toString(),
                            ),
                            InfoRow(
                                icon: Icons.phone,
                                info: controller.suppliersList.value.data[index]
                                    .attributes.phone
                                    .toString()),
                            InfoRow(
                                icon: Icons.home,
                                info: controller.suppliersList.value.data[index]
                                    .attributes.address!.isEmpty?'No address' : controller.suppliersList.value.data[index]
                                    .attributes.address
                                    .toString()),
                            InfoRow(
                              icon: Icons.description,
                              info: controller.suppliersList.value.data[index]
                                      .attributes.description!.isEmpty
                                  ? 'No description'
                                  : controller.suppliersList.value.data[index]
                                      .attributes.description
                                      .toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
        ;
      }
    });
  }
}
