import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key}){
    Get.put(HomeController());
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return SafeArea(child: Scaffold(
          appBar: AppBar(
            title:const Text("Home"),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height:80,),
              controller.swipableCards.isNotEmpty?
              Flexible(
                child: CardSwiper(
                  scale: 1,
                  isLoop: false,
                  maxAngle: 0,
                  backCardOffset:const Offset(0, 0),
                  allowedSwipeDirection:AllowedSwipeDirection.only(down: true,left: true),
                  numberOfCardsDisplayed:3,
                  cardsCount: controller.swipableCards.length,
                  onSwipe: (oldIndex,currentIndex,direction)async{
                    if(currentIndex==null){
                      controller.swipableCards=[];
                    }
                    if(currentIndex!=null){
                      controller.reGenerateSwipCard(oldIndex, currentIndex);
                    }
                    controller.update();
                    return true;
                  },
                  cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                    return controller.swipableCards[index].translatedCrards;
                  } ,
                ),
              ):const Center(
                child: Text('No more card exist'),
              ),
            ],
          ),
        ));
      }
    );
  }
}
