import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_all_netguru_value.dart';

part 'netguru_values_list_event.dart';

part 'netguru_values_list_state.dart';

class NetguruValuesListBloc
    extends Bloc<NetguruValuesListEvent, NetguruValuesListState> {
  final GetAllNetguruValue _getAllNetguruValue;

  NetguruValuesListBloc(this._getAllNetguruValue) : super(Empty());

  @override
  Stream<NetguruValuesListState> mapEventToState(
    NetguruValuesListEvent event,
  ) async* {
    if (event is GetAllNetguruValuesEvent) {
      final eitherListOrFailure = await _getAllNetguruValue(NoParams());
      yield* _eitherValueOrErrorState(eitherListOrFailure);
    }
  }

  Stream<NetguruValuesListState> _eitherValueOrErrorState(
    Either<Failure, List<NetguruValue>> failureOrValues,
  ) async* {
    yield failureOrValues.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (value) => LoadedList(value: value),
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
}
