import 'package:dartz/dartz.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';

abstract class NetguruValuesRepository {
  Future<Either<Failure, NetguruValue>> getRandom();

  Future<Either<Failure, NetguruValue>> getRandomFavorite();

  Future<Either<Failure, List<NetguruValue>>> getAll();

  Future<Either<Failure, NetguruValue>> put(NetguruValue value);
}
