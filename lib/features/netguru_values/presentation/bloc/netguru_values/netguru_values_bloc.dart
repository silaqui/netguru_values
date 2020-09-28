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

  @override
  Stream<NetguruValuesState> mapEventToState(
    NetguruValuesEvent event,
  ) async* {
    if (event is GetRandomNetguruValueEvent) {
      final eitherRandomOrFailure = await _getRandom(NoParams());
      yield* _eitherValueOrErrorState(eitherRandomOrFailure);
    } else if (event is GetRandomFavoriteNetguruValueEvent) {
      final eitherRandomOrFailure = await _getRandomFavorite(NoParams());
      yield* _eitherValueOrErrorState(eitherRandomOrFailure);
    } else if (event is ToggleFavoriteNetguruValuesEvent) {
      final eitherValuesOrFailure = await _toggleFavorite(event.value);
      yield* _eitherUpdatedOrErrorState(eitherValuesOrFailure);
    }
  }
}

Stream<NetguruValuesState> _eitherValueOrErrorState(
  Either<Failure, NetguruValue> failureOrValues,
) async* {
  yield failureOrValues.fold(
    (failure) => Error(message: _mapFailureToMessage(failure)),
    (value) => Loaded(value: value),
  );
}

Stream<NetguruValuesState> _eitherUpdatedOrErrorState(
  Either<Failure, NetguruValue> failureOrValues,
) async* {
  yield failureOrValues.fold(
    (failure) => Error(message: _mapFailureToMessage(failure)),
    (value) => Updated(value: value),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case MemoryFailure:
      return MEMORY_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
