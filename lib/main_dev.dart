import 'package:new_app/commons/app_environment.dart';

import 'main.dart';

void main() async {
  currentEnvironment = Environment.dev;
  await loadApp();
}
