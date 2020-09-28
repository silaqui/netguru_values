part of 'netguru_values_bloc.dart';

@immutable
abstract class NetguruValuesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRandomNetguruValueEvent extends NetguruValuesEvent {}

class GetRandomFavoriteNetguruValueEvent extends NetguruValuesEvent {}

class ToggleFavoriteNetguruValuesEvent extends NetguruValuesEvent {
  final NetguruValue value;

  ToggleFavoriteNetguruValuesEvent(this.value);

  @override
  List<Object> get props => [value];
}
