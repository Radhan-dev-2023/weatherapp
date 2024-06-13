
import 'package:flutter/material.dart';

import 'constants.dart';

Widget customContainer(BuildContext ctx,String? text1,String? text2,Color? textColor,String? imageUrl1,String? imageUrl2,String? text3,String? text4){
return Padding(
  padding: const EdgeInsets.all(5.0),
  child: Row(
    children: [
      Container(

        height: MediaQuery.of(ctx).size.height*0.2,
        width: MediaQuery.of(ctx).size.width*0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child:  Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(ctx).size.height*0.1,width: MediaQuery.of(ctx).size.width*0.17,
              child: Image.asset(
                imageUrl1!,),
            ),
            Text(
              text3!,
              style: f24WhiteBold,
            ),
            Text(
              text1!,
              style: fBlackBold
            ),
          ],
        ),
      ),
      SizedBox(width: MediaQuery.of(ctx).size.width*0.4,),
      Container(
        height: MediaQuery.of(ctx).size.height*0.2,width: MediaQuery.of(ctx).size.width*0.17,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child:  Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(ctx).size.height*0.1,width: MediaQuery.of(ctx).size.width*0.17,
              child: Image.asset(
                imageUrl2!,),
            ),
            Text(
              text4!,
              style: f24WhiteBold
            ),
            Text(
              text2!,
              style: fBlackBold
            ),
          ],
        ),
      ),
    ],
  ),
);
}