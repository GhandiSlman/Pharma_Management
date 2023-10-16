
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_man/core/const/appcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../../controllers/main_controller.dart';

// ignore: must_be_immutable
class CarouselSliderItems extends StatelessWidget {
  CarouselSliderItems({Key? key}) : super(key: key);
  final MainController mainController = Get.put(MainController());
  //CarouselController  carouselController = CarouselController();

  
  
  List<String> imageList = [
    'https://images.unsplash.com/photo-1585435557343-3b092031a831?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    'https://www.otowngist.com/wp-content/uploads/2018/05/codeine24.jpg',
    'https://th.bing.com/th/id/R.f43d67c955572edd8e3127da8d64bba1?rik=EiGPJKK%2b6kngRw&pid=ImgRaw&r=0',
    
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Stack(
      children: [
        
         
           
              CarouselSlider.builder(
              itemCount: imageList.length,
              //carouselController: carouselController,
              options: CarouselOptions(
                viewportFraction: 0.8,
             //   height: 250,
                autoPlay: true,
                aspectRatio: 8/3,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlayInterval: Duration(seconds: 5),
                onPageChanged: (index, reason) => mainController.currentIndexCarousel.value=index,
              ),
              itemBuilder: (context, index, realIndex) {
                return Container(
                 width: MediaQuery.of(context).size.width-20,
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: NetworkImage(imageList[index]),fit:BoxFit.fill ),
                    
                  ),
                  
                );
              },
                 
                     ),
          
        
        
           Positioned(
            bottom: 10,
            left: 0,
            right: 0,
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 AnimatedSmoothIndicator(
                    activeIndex: mainController.currentIndexCarousel.value,
                     count: imageList.length,
                     effect: ExpandingDotsEffect(
                     
                     dotHeight: 10,
                     dotWidth: 10,
                     activeDotColor: AppColor.color2
                     
                     
                     ),
                     ),
               ],
             ),
           ),
        
        
      ],
    ));
  }
}

// class CarouselController {
// }


//...................................................................
// Obx(()=>Stack(
          //   children: [
              
                   
          //          InkWell(
          //           onTap: () {
          //             print(mainController.currentIndexs);
          //           },
          //           child: CarouselSlider(
          //             items: imageList
          //                 .map(
          //                   (item) =>  Padding(
          //                     padding: const EdgeInsets.symmetric(horizontal: 5),
          //                     child: Container(
          //                       height: 100,
          //                       width: double.infinity,
          //                       decoration: BoxDecoration(
          //                         color: black,
          //                         borderRadius: BorderRadius.circular(25),
          //                       ),
          //                       child: Image.asset(
                                  
          //                           item['image_path'],
                                   
          //                          fit: BoxFit.fill,
          //                          width: double.infinity,
          //                         ),
          //                     ),
          //                   ),
                            
          //                 )
          //                 .toList(),
          //             carouselController: carouselController,
          //             options: CarouselOptions(
                        
          //               scrollPhysics: const BouncingScrollPhysics(),
          //               autoPlay: true,
          //             autoPlayInterval: Duration(seconds: 5),
          //               enlargeCenterPage: true,
          //              animateToClosest:false,
          //               aspectRatio: 8/3,
          //               viewportFraction: 1,
                        
          //               onPageChanged: (index, reason) {
                          
          //                   mainController.currentIndexs.value = index;
                         
          //               },
          //             ),
          //           ),
          //       ),
          //       // ),
              
          //     Positioned(
          //       bottom: 10,
          //       left: 0,
          //       right: 0,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: imageList.asMap().entries.map((entry) {
          //           return GestureDetector(
          //             onTap: () => carouselController.animateToPage(entry.key),
          //             child: Container(
          //               width: mainController.currentIndexs.value == entry.key ? 17 : 7,
          //               height: 7.0,
          //               margin: const EdgeInsets.symmetric(
          //                 horizontal: 3.0,
          //               ),
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10),
          //                   color: mainController.currentIndexs.value == entry.key
          //                       ? mainColor
          //                       : Colors.teal),
          //             ),
          //           );
          //         }).toList(),
          //       ),
          //     ),
          //   ],
          // ),
          // ),