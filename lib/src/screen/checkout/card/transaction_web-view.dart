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

  _loadHTML() async {
    webViewController?.loadData(
        data: widget.htmlData.data.callbackResponse, mimeType: 'text/html', encoding: 'utf-8');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body:InAppWebView(
        initialUrlRequest: URLRequest(url:Uri.parse(widget.htmlData.data.callbackUrl) ),
        onUpdateVisitedHistory: (a,b,c){
          print(b!.path);
          print("tessssssssssss");
        },
        key: webViewKey,
        initialOptions:options,
        onReceivedServerTrustAuthRequest: (controller, challenge) async {
          print(challenge);
          return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
        },
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStart: (controller,url){
          print(url!.path);
        },
        onLoadStop:(controller,url){
          print(url!.path+'end');
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
