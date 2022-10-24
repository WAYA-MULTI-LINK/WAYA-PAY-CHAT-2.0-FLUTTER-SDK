import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandomFunction{



  static sheet(BuildContext context,Widget body,{double? height}) {
    var size = MediaQuery.of(context).size;
    showCupertinoModalPopup(
        context: context,
        builder: (context){
          return SizedBox(
            height:size.height,
            width: size.width,
            child: body,
          );
        }
    );
  }

}