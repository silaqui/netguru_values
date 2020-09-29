import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/expandable_fab.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/values_body.dart';
import 'package:netguru_values/features/routes/router.gr.dart';

class NetguruValuesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Netguru Values'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: ValuesBody(),
      floatingActionButton: ExpandableFab(
        children: <Widget>[
          add(context),
          valueList(context),
          toggleOnlyFavorite()
        ],
      ),
    );
  }

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

  Widget toggleOnlyFavorite() {
    return FloatingActionButton(
      onPressed: () => {},
      tooltip: 'Show Favorite',
      heroTag: 'Show Favorite',
      child: Icon(Icons.favorite_border),
    );
  }
}
