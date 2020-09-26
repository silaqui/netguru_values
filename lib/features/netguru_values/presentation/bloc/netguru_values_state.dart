part of 'netguru_values_bloc.dart';

@immutable
abstract class NetguruValuesState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initial extends NetguruValuesState {}

class Empty extends NetguruValuesState {}

class Loading extends NetguruValuesState {}

class Loaded extends NetguruValuesState {
  final NetguruValue value;

  Loaded({@required this.value});

  @override
  List<Object> get props => [value];
}

class Error extends NetguruValuesState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
