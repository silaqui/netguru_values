import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values/netguru_values_bloc.dart';

class FavoriteSwitch extends StatefulWidget {
  @override
  _FavoriteSwitchState createState() => _FavoriteSwitchState();
}

class _FavoriteSwitchState extends State<FavoriteSwitch> {
  bool toggleState = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        toggleState = !toggleState;
        context.bloc<NetguruValuesBloc>().add(
              toggleState
                  ? GetRandomFavoriteNetguruValueEvent()
                  : GetRandomNetguruValueEvent(),
            );
        setState(() {});
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: toggleState
            ? Icon(
                Icons.favorite,
                key: const Key("favorite"),
              )
            : Icon(
                Icons.favorite_border,
                key: const Key("favorite_border"),
              ),
      ),
    );
  }
}
