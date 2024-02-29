import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/ui/pages/home/home_cubit.dart';
import 'package:new_app/ui/pages/home/home_page.dart';
import 'package:new_app/ui/pages/setting/setting_page.dart';

Handler notHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      Scaffold(
    body: Center(
      child: Text('$params'),
    ),
  ),
);

Handler homeHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      BlocProvider(
    create: (context) => HomeCubit(),
    child: const HomePage(),
  ),
);

Handler settingHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const SettingPage());
