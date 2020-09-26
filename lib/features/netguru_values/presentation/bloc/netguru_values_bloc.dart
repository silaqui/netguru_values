import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/put_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/toggle_favorite_netguru_value.dart';

part 'netguru_values_event.dart';

part 'netguru_values_state.dart';

class NetguruValuesBloc extends Bloc<NetguruValuesEvent, NetguruValuesState> {
  final GetAllNetguruValues getAllNetguruValues;
  final GetRandomNetguruValue getRandomNetguruValue;
  final GetRandomFavoriteNetguruValue getRandomFavoriteNetguruValue;
  final PutNetguruValue putNetguruValue;
  final ToggleFavoriteNetguruValue toggleFavoriteNetguruValue;

  NetguruValuesBloc(
    this.getAllNetguruValues,
    this.getRandomNetguruValue,
    this.getRandomFavoriteNetguruValue,
    this.putNetguruValue,
    this.toggleFavoriteNetguruValue,
  ) : super(Initial());

  @override
  Stream<NetguruValuesState> mapEventToState(
    NetguruValuesEvent event,
  ) async* {
    //TODO
  }
}
