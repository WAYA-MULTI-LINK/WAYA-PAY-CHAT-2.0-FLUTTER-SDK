import 'package:flutter/material.dart';
import 'package:wayapay/src/models/htm_data.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CardWebView extends StatefulWidget {
 final HtmlData htmlData;

  const CardWebView({Key? key, required this.htmlData}) : super(key: key);

  @override
  State<CardWebView> createState() => _CardWebViewState();
}

class _CardWebViewState extends State<CardWebView> {
  final GlobalKey webViewKey = GlobalKey();




  @override
  Widget build(BuildContext context) {
    print(widget.htmlData.data.callbackUrl);
    return Scaffold(
      appBar: appBar(context),
      body:WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://flutter.dev',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
}
