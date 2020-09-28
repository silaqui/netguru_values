part of 'add_value_bloc.dart';

@immutable
abstract class AddValueEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveNewValueEvent extends AddValueEvent {
  final String netguruValueText;

  SaveNewValueEvent(this.netguruValueText);

  @override
  List<Object> get props => [netguruValueText];
}

class NewValueSavedEvent extends AddValueEvent {}
