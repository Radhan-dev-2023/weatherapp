
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget sheet(BuildContext ctx,IconData? icon1,String? text1,IconData? icon2,String? text2,String? text3,String? text4){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        width: MediaQuery.of(ctx).size.width * 0.3,
        height: MediaQuery.of(ctx).size.height * 0.20,
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.black,
          ),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon1!,
              size: 60,),
            Text(text3!,style:f24WhiteBold,),
            Text(text1!,style: fBlackBold),

          ],
        ),
      ),
      Container(
        width: MediaQuery.of(ctx).size.width * 0.3,
        height: MediaQuery.of(ctx).size.height * 0.2,
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: Colors.black,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon2!,

              size: 60,),
            Text(text4!,style:f24WhiteBold),
            Text(text2!,style: fBlackBold),

          ],
        ),

      ),
    ],
  );
}