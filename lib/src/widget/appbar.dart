import 'package:flutter/material.dart';
import 'package:wayapay/src/res/color.dart';

AppBar appBar(BuildContext context){
  return AppBar(
    systemOverlayStyle: kOverlay,
    iconTheme:const IconThemeData(color: Colors.white),
    backgroundColor: AppColor.mainColor,
    centerTitle: true,
    title:  SizedBox(
        height: 31,
        child: Image.asset("assets/images/waya_pay.png",package: 'wayapay',)),
  );
}