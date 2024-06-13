import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'constants.dart';

Widget errorData(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please Check Your:',
          style: fBlackBold,
        ),
        Text(
          '1).Permission',
          style: fRedBold,
        ),
        Text(
          '2).Internet Connection',
          style: fRedBold,
        ),
        Text(
          '3).GPS',
          style: fRedBold,
        ),
        Text(
          '4).Please try after sometimes\n     Error: City not found',
          style: fRedBold,
        ),

      ],
    ),

  );

}

