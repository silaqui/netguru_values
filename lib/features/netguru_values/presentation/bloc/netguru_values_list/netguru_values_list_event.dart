part of 'netguru_values_list_bloc.dart';

@immutable
abstract class NetguruValuesListEvent {}

class GetAllNetguruValuesEvent extends NetguruValuesListEvent {}

class ToggleFavoriteNetguruValuesEvent extends NetguruValuesListEvent {
  final NetguruValue value;

  ToggleFavoriteNetguruValuesEvent(this.value);

  @override
  List<Object> get props => [value];
}
