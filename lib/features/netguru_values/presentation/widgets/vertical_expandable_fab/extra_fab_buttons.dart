import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:netguru_values/features/routes/router.gr.dart';

Widget add(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => ExtendedNavigator.of(context).push(Routes.addValuePage),
    tooltip: 'Add Your Value',
    heroTag: 'Add Your Value',
    child: Icon(Icons.add),
  );
}

Widget valueList(BuildContext context) {
  return FloatingActionButton(
    onPressed: () =>
        ExtendedNavigator.of(context).push(Routes.netguruValuesListPage),
    tooltip: 'All Our Values',
    heroTag: 'All Our Values',
    child: Icon(Icons.list),
  );
}
