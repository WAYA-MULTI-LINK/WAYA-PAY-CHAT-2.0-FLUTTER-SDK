import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/screen/main_page/payment_page.dart';
import 'package:wayapay/src/utils/route_transaction.dart';


class WayapayRouterDelegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final _pages = <Page>[];





  @override
  final navigatorKey = GlobalKey<NavigatorState>();
 Charge charge;
  WayapayRouterDelegate(this.charge);

  @override
  List<Page> get currentConfiguration => List.of(_pages);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
      transitionDelegate: const MyTransitionDelegate(),
    );
  }

  @override
  Future<bool> popRoute() {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }

    return Exit().confirmAppExit(navigatorKey);
  }

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) {
    _setPath(configuration
        .map((routeSettings) => _createPage(routeSettings))
        .toList());
    return Future.value(null);
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;

    popRoute();
    return true;
  }

  void _setPath(List<Page> pages) {
    _pages.clear();
    _pages.addAll(pages);

    if (_pages.first.name != '/') {
      _pages.insert(0, _createPage(const RouteSettings(name: '/')));
    }
    notifyListeners();
  }

  void pushPage({required String name, dynamic arguments}) {
    _pages.add(_createPage(RouteSettings(name: name, arguments: arguments)));
    notifyListeners();
  }

  MaterialPage _createPage(RouteSettings routeSettings) {
    Widget child;

    switch (routeSettings.name) {
      case '/':
        child = PaymentPage(charge: charge) ;
        break;
      case '/recipe':
        child = Scaffold(
          appBar: AppBar(title: const Text('testing')),
          body: const Center(child: Text('Tesitng page')),
        );
        break;
      default:
        child = Scaffold(
          appBar: AppBar(title: const Text('404')),
          body: const Center(child: Text('Page not found')),
        );
    }

    return MaterialPage(
      child: child,
      key: Key(routeSettings.toString()) as LocalKey,
      name: routeSettings.name,
      arguments: routeSettings.arguments,
    );
  }


}
class Exit{
  Future<bool> confirmAppExit(var navigatorKey) async {
    String confirmationMessage = 'Do you want to cancel payment?';
    final result = await showDialog<bool>(
        context: navigatorKey!.currentContext!,
        builder: (context) {
          return Platform.isIOS
              ? CupertinoAlertDialog(
            content: Text(confirmationMessage),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Yes')),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: (){
                    Navigator.pop(context,false);

                  },
                  child: const Text('No')),
            ],
          )
              : AlertDialog(
            content: Text(confirmationMessage),
            actions: <Widget>[
              TextButton(
                  child: const Text('NO'),
                  onPressed: () => Navigator.pop(context,false)
                // Pops the confirmation dialog but not the page.
              ),
              TextButton(
                  child: const Text('YES'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  })
            ],
          );
        });

    return result ?? true;
  }
}
