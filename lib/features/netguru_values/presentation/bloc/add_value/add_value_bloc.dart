import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/put_netguru_value.dart';

part 'add_value_event.dart';
part 'add_value_state.dart';

class AddValueBloc extends Bloc<AddValueEvent, AddValueState> {
  final PutNetguruValue _putNetguruValue;

  AddValueBloc(this._putNetguruValue) : super(Initial());

  @override
  Stream<AddValueState> mapEventToState(
    AddValueEvent event,
  ) async* {
    if (event is SaveNewValueEvent) {
      final newValue = NetguruValueModel(text: event.netguruValueText);
      yield Saving();
      final eitherSavedOrFailure = await _putNetguruValue(newValue);
      yield* _eitherValueOrErrorState(eitherSavedOrFailure);
    }
  }

  Stream<AddValueState> _eitherValueOrErrorState(
    Either<Failure, int> failureOrValues,
  ) async* {
    yield failureOrValues.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (value) => Saved(),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case MemoryFailure:
        return memoryFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
