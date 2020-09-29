import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values/netguru_values_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/value_display.dart';

class ValuesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetguruValuesBloc, NetguruValuesState>(
      builder: (BuildContext context, NetguruValuesState state) {
        return AnimatedSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 500),
          child: _buildPage(context, state),
        );
      },
    );
  }

  Widget _buildPage(BuildContext context, NetguruValuesState state) {
    if (state is Loaded) {
      return ValueDisplay(
          key: Key(state.value.id.toString()), netguruValue: state.value);
    } else if (state is Error) {
      return _noValueMessage();
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _noValueMessage() {
    return const Center(
        child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              "We could not get value for you",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            )));
  }
}
