import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values/netguru_values_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/value_display.dart';

class ValuesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetguruValuesBloc, NetguruValuesState>(
      builder: (BuildContext context, NetguruValuesState state) {
        if (state is Initial) {
          BlocProvider.of<NetguruValuesBloc>(context)
              .add(GetRandomNetguruValueEvent());
          return Container();
        } else if (state is Loaded) {
          return ValueDisplay(netguruValue: state.value);
        } else if (state is Error) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              "We could not get value for you",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
