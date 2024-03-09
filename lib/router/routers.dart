import 'package:fluro/fluro.dart';
import 'package:new_app/router/router_handler.dart';

class Routes {
  /// Router path
  static String home = "/";
  static String setting = "/setting";

  /// Setup route for the app
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notHandler;

    router.define(
      home,
      handler: homeHandler,
      transitionType: TransitionType.inFromLeft,
    );

    router.define(
      setting,
      handler: settingHandler,
      transitionType: TransitionType.inFromLeft,
    );
  }
}
