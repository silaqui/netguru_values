import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:netguru_values/features/routes/router.gr.dart';

import '../circular_button.dart';

Widget addRadial(BuildContext context) {
  return CircularButton(
    color: Theme.of(context).secondaryHeaderColor,
    child: IconButton(
        icon: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () =>
            ExtendedNavigator.of(context).push(Routes.addValuePage)),
  );
}

Widget valueListRadial(BuildContext context) {
  return CircularButton(
    color: Theme.of(context).secondaryHeaderColor,
    child: IconButton(
        icon: Icon(
          Icons.list,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () =>
            ExtendedNavigator.of(context).push(Routes.netguruValuesListPage)),
  );
}
