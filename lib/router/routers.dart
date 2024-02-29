import 'package:fluro/fluro.dart';
import 'package:new_app/router/router_handler.dart';

class Routes {
  static String home = "/";
  static String setting = "/setting";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notHandler;

    router.define(
      home,
      handler: homeHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      setting,
      handler: settingHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}
