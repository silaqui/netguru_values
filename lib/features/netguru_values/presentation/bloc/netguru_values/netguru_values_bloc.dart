import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_favorite_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/toggle_favorite_netguru_value.dart';

part 'netguru_values_event.dart';
part 'netguru_values_state.dart';

class NetguruValuesBloc extends Bloc<NetguruValuesEvent, NetguruValuesState> {
  final GetRandomNetguruValue _getRandom;
  final GetRandomFavoriteNetguruValue _getRandomFavorite;
  final ToggleFavoriteNetguruValue _toggleFavorite;

  NetguruValuesBloc(
    this._getRandom,
    this._getRandomFavorite,
    this._toggleFavorite,
  ) : super(Initial());

  StreamSubscription<Either<Failure, NetguruValue>> _streamSubscription;

  Stream<Either<Failure, NetguruValue>> getRandomValuesStream() async* {
    while (true) {
      yield await _getRandom(NoParams());
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  Stream<Either<Failure, NetguruValue>> getRandomFavoriteValuesStream() async* {
    while (true) {
      yield await _getRandomFavorite(NoParams());
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  Stream<NetguruValuesState> mapEventToState(
    NetguruValuesEvent event,
  ) async* {
    if (event is GetRandomNetguruValueEvent) {
      yield Loading();
      await _streamSubscription?.cancel();
      _streamSubscription = getRandomValuesStream().listen((event) {
        add(ValueReceived(event));
      });
    } else if (event is GetRandomFavoriteNetguruValueEvent) {
      yield Loading();
      await _streamSubscription?.cancel();
      _streamSubscription = getRandomFavoriteValuesStream().listen((event) {
        add(ValueReceived(event));
      });
    } else if (event is ValueReceived) {
      yield event.value.fold(
              (failure) => Error(message: _mapFailureToMessage(failure)),
              (value) => Loaded(value: value));
    } else if (event is ToggleFavoriteNetguruValuesEvent) {
      yield (await _toggleFavorite(event.value)).fold(
              (failure) => Error(message: _mapFailureToMessage(failure)),
              (value) => Loaded(value: value));
    }
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case MemoryFailure:
      return memoryFailureMessage;
    default:
      return 'Unexpected error';
  }
}
