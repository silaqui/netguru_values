import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/add_value/add_value_bloc.dart';

class AddValueScaffold extends StatelessWidget {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Values'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            ExtendedNavigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              BlocProvider.of<AddValueBloc>(context)
                  .add(SaveNewValueEvent(_textController.text));
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _textController,
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
            maxLength: 500,
            maxLengthEnforced: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Tell us what matters to you."),
          ),
        ),
      ),
    );
  }
}
