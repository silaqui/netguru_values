import 'package:equatable/equatable.dart';

const MEMORY_FAILURE_MESSAGE = 'Memory failure';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class MemoryFailure extends Failure {}
