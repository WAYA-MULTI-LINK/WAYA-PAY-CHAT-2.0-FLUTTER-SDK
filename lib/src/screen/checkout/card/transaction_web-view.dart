import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wayapay/src/models/htm_data.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body:InAppWebView(
        initialUrlRequest: URLRequest(url:Uri.parse(widget.htmlData.data.callbackUrl) ),
        onUpdateVisitedHistory: (a,b,c){
         if(b!=null){
           var uri = b!;
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
            var uri = b!;
            var link = uri.host+uri.path+uri.fragment;
          }
        },
        onLoadStop:(controller,b){
          if(b!=null){
            var uri = b!;
            var link = uri.host+uri.path+uri.fragment;


          }
        },
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },

      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_loadHTML();
  }
}
