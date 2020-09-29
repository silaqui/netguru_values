import 'package:dartz/dartz.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/repositories/netguru_values_repository.dart';

class PutNetguruValue implements UseCase<int, NetguruValue> {
  final NetguruValuesRepository repository;

  PutNetguruValue(this.repository);

  @override
  Future<Either<Failure, int>> call(NetguruValue params) async {
    // ignore: unnecessary_await_in_return
    return await repository.put(params);
  }
}
