part of 'add_value_bloc.dart';

@immutable
abstract class AddValueState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initial extends AddValueState {}

class Saving extends AddValueState {}

class Saved extends AddValueState {}

class Error extends AddValueState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
