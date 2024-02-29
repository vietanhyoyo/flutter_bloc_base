import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:new_app/ui/pages/home/home_page.dart';
import 'package:new_app/ui/pages/setting/setting_page.dart';

class Routes {
  static String home = "/";
  static String setting = "/setting";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
          Scaffold(
        body: Center(
          child: Text('$params'),
        ),
      ),
    );
    router.define(
      home,
      handler: Handler(
          handlerFunc:
              (BuildContext? context, Map<String, List<String>> params) =>
                  const HomePage()),
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      setting,
      handler: Handler(
          handlerFunc:
              (BuildContext? context, Map<String, List<String>> params) =>
                  const SettingPage()),
      transitionType: TransitionType.fadeIn,
    );
  }
}
