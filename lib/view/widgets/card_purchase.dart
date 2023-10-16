import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/controllers/all_purchase_controller.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:pharma_man/core/const/routes.dart';
import 'package:pharma_man/model/purchase.dart';
import 'package:pharma_man/view/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CardPurchase extends StatelessWidget {
  CardPurchase({this.purchase, Key? key}) : super(key: key);
  final AllPurchaseController controller = Get.put(AllPurchaseController());
  final Purchases? purchase;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: controller.getPurchase(),
          builder: (context, AsyncSnapshot snapshot) {
            Purchases? data = snapshot.data;
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: data!.data.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: InkWell(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this purchase?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await controller.deletePurchase(
                                          data.data[index].attributes.id);
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
                          elevation: 10,
                          shadowColor: AppColor.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            height: 25.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.white),
                            child: Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 20.h,
                                    width: 29.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SizedBox(
                                      child: 
                                      Image.asset('assets/images.jpeg')
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 18,
                                // ),
                                Expanded(
                                  child: Container(
                                    //   color: AppColor.black,
                                    height: 25.h,
                                    width: 30.w,
                                    child: Column(
                                      //  mainAxisAlignment:
                                      // MainAxisAlignment
                                      //     .start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(
                                        //   height: 20,
                                        // ),

                                        Row(
                                          children: [
                                            CustomText(
                                              textAlign: TextAlign.center,
                                              text: 'Name :',
                                              size: 20,
                                              color: AppColor.black,
                                              wieght: FontWeight.w900,
                                              textDirection: TextDirection.ltr,
                                            ),
                                            Expanded(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: CustomText(
                                                  textAlign: TextAlign.center,
                                                  text:
                                                      ' ${data.data[index].attributes.name}',
                                                  size: 20,
                                                  color: AppColor.grey,
                                                  wieght: FontWeight.w700,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 3.h,
                                        ),

                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: AppColor.mainColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: CustomText(
                                                overflow: TextOverflow.clip,
                                                text:
                                                    "NetPrice= ${data.data[index].attributes.netPrice}\$",
                                                size: 15,
                                                color: Colors.white,
                                                wieght: FontWeight.w400),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.mainColor,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: CustomText(
                                                text:
                                                    'SallingPrice= ${data.data[index].attributes.sallingPrice}\$ ',
                                                size: 15.5,
                                                color: AppColor.white,
                                                wieght: FontWeight.w400),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: AppColor.mainColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: CustomText(
                                                overflow: TextOverflow.clip,
                                                text:
                                                    "Quantity= ${data.data[index].attributes.quantity}",
                                                size: 15,
                                                color: AppColor.white,
                                                wieght: FontWeight.w400),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Container(
                                          height: 3.h,
                                          decoration: BoxDecoration(
                                            color: AppColor.mainColor,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: CustomText(
                                                text:
                                                    'Date: ${data.data[index].attributes.expiryDate.toString().substring(0, 10)}',
                                                size: 15.5,
                                                color: AppColor.white,
                                                overflow: TextOverflow.clip,
                                                wieght: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      String purchaseId = data
                                          .data[index].attributes.id
                                          .toString();
                                      print('tare=${data.data[index].attributes.id}');
                                      Get.toNamed(
                                      AppRoute.editPurchase,
                                      arguments: purchaseId,
                                    );
                                       
                                    },
                                    icon: Icon(Icons.edit))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return 
              Center(
                  child: CircularProgressIndicator(
                color: AppColor.color1,
              ));
            }
          }),
    );
  }
}
