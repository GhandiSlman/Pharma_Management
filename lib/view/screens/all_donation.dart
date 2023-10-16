
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/donation_controller.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/const/routes.dart';
import 'package:pharma_man/view/widgets/custom_floating_button.dart';
import 'package:pharma_man/view/widgets/custom_icon_button.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../../model/donation.dart';

// ignore: must_be_immutable
class AllDonations extends StatelessWidget {
  DonationController controller = Get.put(DonationController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: CustomFloatingButton(
          icon: Icon(Icons.add),
          color: AppColor.color1,
          onPressed: () {
            Get.offNamed(AppRoute.addDonation);
          },
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColor.color1,
            ));
          } else {
            return Container(
              padding: EdgeInsets.all(3.h),
              child: FutureBuilder<AllDonation>(
                future: controller.getAllDonations(),
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
                        color: AppColor.red,
                        size: 20.sp,
                        text: 'No Profiles available',
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
                            InkWell(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Deletion'),
                                      content: const Text(
                                          'Are you sure you want to delete this donation?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            final id = data.id.toString();
                                            controller.deleteDonation(id);
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
                                elevation: 4,
                                color: AppColor.color4,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.h)),
                                  width: double.infinity,
                                  height: 30.h,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              Icons.medical_services_outlined,
                                              color: AppColor.mainColor,
                                              size: 6.h,
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            SizedBox(
                                              width: 33.w,
                                              child: CustomText(
                                                text: '${data.productName}',
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
                                                  final id = data.id.toString();
                                                  Get.offNamed(
                                                      AppRoute.updateDonation,
                                                      arguments: id);
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
                                              Icons.production_quantity_limits,
                                              color: AppColor.mainColor,
                                              size: 3.h,
),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            CustomText(
                                              text: '${data.quantity}',
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
                                              text: '${data.expiryDate}',
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
                                              Icons.qr_code_2_outlined,
                                              color: AppColor.mainColor,
                                              size: 3.h,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            CustomText(
                                              text: '${data.paracode}',
                                              size: 15.sp,
                                              wieght: FontWeight.normal,
                                              color: AppColor.grey,
                                              overflow: TextOverflow
                                                  .clip, // set overflow to clip
                                            ),
                                          ],
                                        )
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
            );
}
        }));
  }
}
