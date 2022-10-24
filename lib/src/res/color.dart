import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColor{
 static const Color mainColor =  Color(0xffFF4400);
 static const  Color mainLightColor =   Color.fromRGBO(255, 102, 52, 0.13);
 static const Color borderColor =  Color(0xffF2F2F2);


}


const kOverlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light
);