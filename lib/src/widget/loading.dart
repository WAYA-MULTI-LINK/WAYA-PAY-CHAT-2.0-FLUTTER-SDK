import 'package:animated_rotating_widget/animated_rotating_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatefulWidget {
 final String message;
 final  BuildContext context;
 final Function(BuildContext context) onLoading;

  const Loading({
    required this.onLoading,
    required this.message,
    Key? key, required this.context
  }) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Column(
          children: [
            AnimatedRotatingWidget(
              duration: const Duration(milliseconds: 1500),
              child: Image.asset(
                'assets/images/spin.png',
                key: const Key("IssuerIcon"),
                height: height * 0.17,
                width: width * 0.17,
                package: 'wayapay',
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: (width * height) * 0.00005)),
            ),
          ],
        )
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000),(){
      widget.onLoading(widget.context);
    });
  }
}
