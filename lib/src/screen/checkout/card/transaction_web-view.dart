import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/alert/alert.dart';
import 'package:wayapay/src/models/htm_data.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/checkout/card/web_background.dart';
import 'package:wayapay/src/widget/appbar.dart';

class CardWebView extends StatefulWidget {
 final HtmlData htmlData;

  const CardWebView({Key? key, required this.htmlData}) : super(key: key);

  @override
  State<CardWebView> createState() => _CardWebViewState();
}

class _CardWebViewState extends State<CardWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        safeBrowsingEnabled: false
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,

      ));


  var wayaPay = "pay.wayapay.ng";
  bool hasOpen = false;
  int index =0;
  @override
  Widget build(BuildContext context) {
    var model = context.watch<TransactionProvider>();
    print(widget.htmlData.data.callbackUrl);
    return Scaffold(
      appBar: appBar(context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //   check(model, context);
      //   },
      // ),
      body:IndexedStack(
        index: index,
        children: [
          const WebBackGround(),
          InAppWebView(
            initialUrlRequest: URLRequest(url:Uri.parse(widget.htmlData.data.callbackUrl) ),
            onUpdateVisitedHistory: (a,b,c){
             if(b!=null){
               var uri = b;
               var link = uri.host+uri.path+uri.fragment;
             }
             },
            key: webViewKey,
            initialOptions:options,
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
            },
            onWebViewCreated: (controller) {
              webViewController = controller;
              },
            onLoadStart: (controller,b){
              if(b!=null){
                var uri = b;
                var link = uri.host+uri.path+uri.fragment;

              }
            },

            onLoadStop:(controller,b){
              if(b!=null){
                var uri = b;
                var link = uri.host+uri.path+uri.fragment;
                setState(() {
                  index=1;
                });
                if(link.contains(wayaPay)&&hasOpen==false){

                  Future.delayed(const Duration(seconds: 3),(){
                    hasOpen=true;
                  });

                  check(model, context,);
                }


              }
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },

          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_loadHTML();
  }

  check(TransactionProvider model, BuildContext context) async{
    Alerts.onProcessingAlert(context,onLoading: (cxt){
      model.checkStatus().then((value){
        Navigator.pop(cxt);
        Future.delayed(const Duration(milliseconds: 500),(){
          // Alerts.onSuccessAlert(context);
          if(value!=null){
            if(value.success){
              Alerts.onSuccessAlert(context);
            }else{
              Alerts.onPaymentFailed(context,message: value.message);
            }
          }
        });

      }).catchError((e){
        Navigator.pop(cxt);
      });
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   webViewController=null;
  }

}
