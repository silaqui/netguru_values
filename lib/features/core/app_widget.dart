import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:netguru_values/core/theme/theme.dart';
import 'package:netguru_values/features/routes/router.gr.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netguru Values',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      builder: ExtendedNavigator(router: Router()),
    );
  }
}
