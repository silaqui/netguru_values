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
          transitionBuilder: _transitionBuilder,
          duration: const Duration(milliseconds: 800),
          child: _buildPage(context, state),
        );
      },
    );
  }

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    final fadeTween = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 0.0), weight: 60.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0), weight: 40.0),
    ]).animate(animation);
    final scaleTween = Tween<double>(begin: 0.90, end: 1.0).animate(animation);
    return ScaleTransition(
      scale: scaleTween,
      child: FadeTransition(
        opacity: fadeTween,
        child: child,
      ),
    );
  }

  Widget _buildPage(BuildContext context, NetguruValuesState state) {
    if (state is Loaded) {
      return ValueDisplay(
          key: Key(state.value.id.toString()), netguruValue: state.value);
    } else if (state is Error) {
      return _noValueMessage(context);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _noValueMessage(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              "We could not get value for you",
              style: TextStyle(
                fontSize: 25,
                color: Color(Theme.of(context).accentColor.value),
              ),
              textAlign: TextAlign.center,
            )));
  }
}
