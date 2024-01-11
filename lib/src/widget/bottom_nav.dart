
import 'package:flutter/material.dart';
import 'package:wayapay/src/models/bottom_nav_model.dart';
import 'package:wayapay/src/res/color.dart';
import 'package:wayapay/src/res/text.dart';

class CustomBottomNav extends StatefulWidget {
 final List<BottomNavModel> items;
 final Function(int e) onTap;
 final int currentIndex;
  const CustomBottomNav({
    Key? key,
    required this.items,
    required this.onTap,
    required this.currentIndex
  }) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:18,right: 18 ),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.grey[200]!
            )
        ),
        child: Row(
          children:widget.items.map((e){
            var index= widget.items.indexOf(e);
            return Expanded(
                child:GestureDetector(
                  onTap: (){
                    widget.onTap(index);
                  },
                  child: Container(
                    height: 70,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5),
                     border: Border.all(
                       width: 1,
                       color: index==widget.currentIndex?AppColor.mainColor
                           :Colors.transparent
                     )
                   ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Icon(e.icon,color: AppColor.mainColor,),
                        Text(e.name,
                        style: AppTextTheme.h3.copyWith(
                          fontSize: 14
                        ),)
                      ],
                    ),
                  ),
                )
            );
          }).toList(),
        ),
      ),
    );
  }
}
