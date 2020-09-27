import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_all_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_favorite_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/put_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/toggle_favorite_netguru_value.dart';

part 'netguru_values_event.dart';

part 'netguru_values_state.dart';

const MEMORY_FAILURE_MESSAGE = 'Memory failure';

class NetguruValuesBloc extends Bloc<NetguruValuesEvent, NetguruValuesState> {
  final GetAllNetguruValue getAll;
  final GetRandomNetguruValue getRandom;
  final GetRandomFavoriteNetguruValue getRandomFavorite;
  final PutNetguruValue put;
  final ToggleFavoriteNetguruValue toggleFavorite;

  NetguruValuesBloc(
    this.getAll,
    this.getRandom,
    this.getRandomFavorite,
    this.put,
    this.toggleFavorite,
  ) : super(Initial());

  @override
  Stream<NetguruValuesState> mapEventToState(
    NetguruValuesEvent event,
  ) async* {
    if (event is GetRandomNetguruValueEvent) {
      yield Loading();
      final eitherRandomOrFailure = await getRandom(NoParams());
      yield* _eitherValueOrErrorState(eitherRandomOrFailure);
    } else if (event is GetRandomFavoriteNetguruValueEvent) {
      yield Loading();
      final eitherRandomOrFailure = await getRandomFavorite(NoParams());
      yield* _eitherValueOrErrorState(eitherRandomOrFailure);
    } else if (event is GetAllNetguruValuesEvent) {
      yield Loading();
      final eitherAllValuesOrFailure = await getAll(NoParams());
      yield* _eitherAllValuesOrErrorState(eitherAllValuesOrFailure);
    } else if (event is AddNetguruValuesEvent) {
      yield Loading();
      final eitherValuesOrFailure = await put(event.value);
      yield* _eitherUpdatedOrErrorState(eitherValuesOrFailure);
    } else if (event is ToggleFavoriteNetguruValuesEvent) {
      yield Loading();
      final eitherValuesOrFailure = await toggleFavorite(event.value);
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

Stream<NetguruValuesState> _eitherAllValuesOrErrorState(
  Either<Failure, List<NetguruValue>> failureOrValue,
) async* {
  yield failureOrValue.fold(
    (failure) => Error(message: _mapFailureToMessage(failure)),
    (value) => LoadedList(value: value),
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
