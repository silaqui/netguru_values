part of 'netguru_values_list_bloc.dart';

@immutable
abstract class NetguruValuesListState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends NetguruValuesListState {}

class LoadedList extends NetguruValuesListState {
  final List<NetguruValue> value;

  LoadedList({@required this.value});

  @override
  List<Object> get props => [value];
}

class Error extends NetguruValuesListState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
