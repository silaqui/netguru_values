import 'package:equatable/equatable.dart';

const memoryFailureMessage = 'Memory failure';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class MemoryFailure extends Failure {}
