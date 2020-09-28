part of 'netguru_values_list_bloc.dart';

@immutable
abstract class NetguruValuesListEvent {
  @override
  List<Object> get props => [];
}

class GetAllNetguruValuesEvent extends NetguruValuesListEvent {}
