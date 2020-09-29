import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_all_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/toggle_favorite_netguru_value.dart';

part 'netguru_values_list_event.dart';
part 'netguru_values_list_state.dart';

class NetguruValuesListBloc
    extends Bloc<NetguruValuesListEvent, NetguruValuesListState> {
  final GetAllNetguruValue _getAllNetguruValue;
  final ToggleFavoriteNetguruValue _toggleFavoriteNetguruValue;

  NetguruValuesListBloc(
      this._getAllNetguruValue, this._toggleFavoriteNetguruValue)
      : super(Empty());

  @override
  Stream<NetguruValuesListState> mapEventToState(
    NetguruValuesListEvent event,
  ) async* {
    if (event is GetAllNetguruValuesEvent) {
      final eitherListOrFailure = await _getAllNetguruValue(NoParams());
      yield eitherListOrFailure.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (value) => LoadedList(value: value));
    } else if (event is ToggleFavoriteNetguruValuesEvent) {
      final eitherUpdatedOrFailure =
          await _toggleFavoriteNetguruValue(event.value);
      if (eitherUpdatedOrFailure.isRight()) {
        add(GetAllNetguruValuesEvent());
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
}
