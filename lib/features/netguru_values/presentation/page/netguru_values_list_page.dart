import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/values_list_body.dart';

class NetguruValuesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Our Values'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ExtendedNavigator.of(context).pop();
          },
        ),
      ),
      body: ValuesListBody(),
    );
  }
}
