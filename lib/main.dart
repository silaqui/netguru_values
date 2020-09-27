import 'package:flutter/material.dart';

import 'dependency_injection.dart' as injector;
import 'features/core/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.init();
  runApp(AppWidget());
}
