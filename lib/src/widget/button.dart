// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayapay/src/common/constants.dart';
import 'package:wayapay/src/enum/app_state.dart';


class WhiteButton extends BaseButton {
  final bool flat;
  final IconData? iconData;
  final bool bold;

  WhiteButton({
    required VoidCallback? onPressed,
    String? text,
    Widget? child,
    this.flat = false,
    this.bold = true,
    this.iconData,
  }) : super(
    onPressed: onPressed,
    showProgress: false,
    text: text,
    child: child,
    iconData: iconData,
    textStyle: TextStyle(
        fontSize: 14.0,
        color: Colors.black87.withOpacity(0.8),
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    color: Colors.white,
    borderSide: flat
        ? BorderSide.none
        : const BorderSide(color: Colors.grey, width: 0.5),
  );
}

class AccentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool showProgress;
  final AppState appState;

  final double fontSize;

  const AccentButton({
    Key? key,
    required this.onPressed,
    this.appState=AppState.idle,
    required this.text,
    this.fontSize = 15,
    this.showProgress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: (){
        if(appState==AppState.idle){
          onPressed();
        }
      },
      showProgress: appState==AppState.idle?false:true,
      color: Constants.wayapay_color,
      borderSide: BorderSide.none,
      textStyle:  TextStyle(
          fontSize: fontSize, color: Colors.white,
          fontWeight: FontWeight.bold),
      text: text,
    );
  }
}

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool showProgress;
  final TextStyle textStyle;
  final Color color;
  final BorderSide borderSide;
  final IconData? iconData;
  final Widget? child;
  final bool? disabled;

  const BaseButton({
    required this.onPressed,
    required this.showProgress,
    required this.text,
    required this.textStyle,
    required this.color,
    this.disabled = false,
    required this.borderSide,
    this.iconData,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(5.0));
    var textWidget;
    if (text != null) {
      textWidget = Text(
        text!,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
            textStyle:  textStyle
        ),
      );
    }
    return Container(
        width: double.infinity,
        height: 59,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: TextButton(
              onPressed: showProgress ? null : disabled! ? null: onPressed,

              child: showProgress
                  ? SizedBox(
                width: 20.0,
                height: 20.0,
                child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch()
                            .copyWith(secondary: Colors.white)),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.0,
                    )),
              )
                  : iconData == null
                  ? child == null
                  ? textWidget
                  : child!
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    iconData,
                    color: textStyle.color!.withOpacity(0.5),
                  ),
                  const SizedBox(width: 2.0),
                  textWidget,
                ],
              )),
        ));
  }
}
