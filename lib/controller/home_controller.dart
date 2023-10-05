import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  List<Color> colorsList=[
    Colors.orangeAccent,
    Colors.pink,
    Colors.lightGreen,
    Colors.purple,
    Colors.orangeAccent,
    Colors.pink,
    Colors.lightGreen,
    Colors.purple,
    Colors.pink,
    Colors.lightGreen,
    Colors.purple,
    Colors.orangeAccent,
  ];
  Offset offset=const Offset(10,-20);
  double rotateZ=0.0;
  Widget? cards;
  Widget? orignalCards;
  List<SwipableCards> swipableCards=[];

  HomeController(){
    prepareSwipCard();
  }
  prepareSwipCard(){
    for(int i=0;i<10;i++){
      cards=Transform(
        transform: Matrix4.identity()..rotateZ(rotateZ),
        child: Transform.translate(
            offset:offset,
            child: Card(
              color: colorsList[i],
              elevation: 5,
              child: Padding(
                padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: SizedBox(
                  height: 150,
                  width: 250,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Lalibela $i',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      const Spacer(),
                     const  Align(
                        alignment: Alignment.bottomLeft,
                        child:Text('From',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                      ),
                     const Align(
                          alignment: Alignment.bottomLeft,
                          child:Text('30,543 ETB',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),)
                      ),
                    ],
                  ),
                ),
              ),
            )
        ),
      );
      orignalCards=Card(
        color: colorsList[i],
        elevation: 5,
        child: Padding(
          padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: SizedBox(
            height: 150,
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Lalibela $i',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                const Spacer(),
                const  Align(
                  alignment: Alignment.bottomLeft,
                  child:Text('From',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child:Text('30,543 ETB',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),)
                ),
              ],
            ),
          ),
        ),
      );
      swipableCards.add(SwipableCards(orginalCrards: orignalCards??Container(), translatedCrards: cards??Container(), offset: offset, zRotation: rotateZ));
      offset+=const Offset(-20,32);
      rotateZ+=-0.09;
    }
  }
  reGenerateSwipCard(int oldIndex,int currentIndex) async{
    SwipableCards currentWidget=swipableCards[currentIndex];
    SwipableCards previousWidget=swipableCards[oldIndex];
    int count=0;
    for(int i=currentIndex;i<swipableCards.length;i++){
      SwipableCards tempWidget=SwipableCards(offset: swipableCards[i].offset,orginalCrards:swipableCards[i].orginalCrards,translatedCrards:swipableCards[i].translatedCrards,zRotation:swipableCards[i].zRotation);
      if(count==0){
        swipableCards[i].translatedCrards=Transform(
          transform: Matrix4.identity()..rotateZ(previousWidget.zRotation),
          child: Transform.translate(
            offset: previousWidget.offset,
            child: swipableCards[i].orginalCrards,
          ),
        );
        swipableCards[i].zRotation=previousWidget.zRotation;
        swipableCards[i].offset=previousWidget.offset;
      }
      else{
        swipableCards[i].translatedCrards=Transform(
          transform: Matrix4.identity()..rotateZ(currentWidget.zRotation),
          child: Transform.translate(
            offset: currentWidget.offset,
            child: swipableCards[i].orginalCrards,
          ),
        );
        swipableCards[i].zRotation=currentWidget.zRotation;
        swipableCards[i].offset=currentWidget.offset;
      }
      currentWidget=tempWidget;
      count++;
    }
    update();
  }
}
class SwipableCards{
Widget translatedCrards;
Widget orginalCrards;
double zRotation=0;
Offset offset=const Offset(0, 0);
SwipableCards({required this.orginalCrards,required this.translatedCrards,required this.offset,required this.zRotation});
}