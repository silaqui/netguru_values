import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values/netguru_values_bloc.dart';

import '../circular_button.dart';

class FavoriteSwitchRadial extends StatefulWidget {
  @override
  _FavoriteSwitchRadialState createState() => _FavoriteSwitchRadialState();
}

class _FavoriteSwitchRadialState extends State<FavoriteSwitchRadial> {
  bool toggleState = false;

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      color: Theme.of(context).secondaryHeaderColor,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: toggleState
            ? IconButton(
                onPressed: () => onPress(),
                icon: Icon(
                  Icons.favorite,
                  color: Theme.of(context).primaryColor,
                ),
                key: const Key("favorite"))
            : IconButton(
                onPressed: () => onPress(),
                icon: Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).primaryColor,
                ),
                key: const Key("favorite_border")),
      ),
    );
  }

  void onPress() {
    toggleState = !toggleState;
    context.bloc<NetguruValuesBloc>().add(
          toggleState
              ? GetRandomFavoriteNetguruValueEvent()
              : GetRandomNetguruValueEvent(),
        );
    setState(() {});
  }
}
