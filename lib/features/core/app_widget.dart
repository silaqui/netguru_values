import 'package:flutter/material.dart';
import 'package:netguru_values/core/theme/theme.dart';
import 'package:netguru_values/features/netguru_values/presentation/page/netguru_values_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netguru Values',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: NetguruValuesPage(),
    );
  }
}
