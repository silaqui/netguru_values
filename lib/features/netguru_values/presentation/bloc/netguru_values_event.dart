part of 'netguru_values_bloc.dart';

@immutable
abstract class NetguruValuesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRandomNetguruValueEvent extends NetguruValuesEvent {}

class GetRandomFavoriteNetguruValueEvent extends NetguruValuesEvent {}

class GetAllNetguruValuesEvent extends NetguruValuesEvent {}

class AddNetguruValuesEvent extends NetguruValuesEvent {
  final NetguruValue value;

  AddNetguruValuesEvent(this.value);

  @override
  List<Object> get props => [value];
}

class ToggleFavoriteNetguruValuesEvent extends NetguruValuesEvent {
  final NetguruValue value;

  ToggleFavoriteNetguruValuesEvent(this.value);

  @override
  List<Object> get props => [value];
}
