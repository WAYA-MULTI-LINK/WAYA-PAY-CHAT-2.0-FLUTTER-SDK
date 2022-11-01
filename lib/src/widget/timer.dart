
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpTimer extends StatefulWidget {
  final Function() onTap;
  const OtpTimer({
    required this.onTap,
    Key? key}) : super(key: key);

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  final CustomTimerController _controller = CustomTimerController();
  @override
  Widget build(BuildContext context) {
    return CustomTimer(
         onChangeState: (e){
           print(e.index);
         },
        controller: _controller,
        begin: const Duration(seconds: 60),
        end: const Duration(seconds: 0),
        builder: (time){
          if(time.seconds=="00"){
            // Future.delayed(const Duration(milliseconds: 500),(){
            //   Navigator.pop(context);
            // });
            return const SizedBox();
          }else{
            return Text(
              "You have ${time.seconds} seconds left",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            );
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.start();
  }
}
