import 'package:dartz/dartz.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/repositories/netguru_values_repository.dart';

class GetAllNetguruValue implements UseCase<List<NetguruValue>, NoParams> {
  final NetguruValuesRepository repository;

  GetAllNetguruValue(this.repository);

  @override
  Future<Either<Failure, List<NetguruValue>>> call(NoParams params) async {
    return await repository.getAll();
  }
}
