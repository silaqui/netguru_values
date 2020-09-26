part of 'netguru_values_bloc.dart';

@immutable
abstract class NetguruValuesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRandomNetguruValue extends NetguruValuesEvent {}

class GetRandomFavoriteNetguruValue extends NetguruValuesEvent {}

class GetAllNetguruValues extends NetguruValuesEvent {}

class AddNetguruValues extends NetguruValuesEvent {
  final NetguruValue value;

  AddNetguruValues(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateNetguruValues extends NetguruValuesEvent {
  final NetguruValue value;

  UpdateNetguruValues(this.value);

  @override
  List<Object> get props => [value];
}
