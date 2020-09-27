import 'package:flutter/material.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/values_body.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/values_fab.dart';

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
      floatingActionButton: ValuesFab(),
    );
  }
}
