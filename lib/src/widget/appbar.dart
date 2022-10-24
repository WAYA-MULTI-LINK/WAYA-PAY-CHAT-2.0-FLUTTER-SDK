import 'package:flutter/material.dart';
import 'package:wayapay/src/res/color.dart';

AppBar appBar(BuildContext context){
  return AppBar(
    systemOverlayStyle: kOverlay,
    iconTheme:const IconThemeData(color: Colors.white),
    backgroundColor: AppColor.mainColor,
  );
}