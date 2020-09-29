import 'package:dartz/dartz.dart';
import 'package:netguru_values/core/error/exceptions.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/netguru_values_local_datasource.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/repositories/netguru_values_repository.dart';

class NetguruValuesRepositoryImpl implements NetguruValuesRepository {
  final NetguruValuesLocalDataSource dataSource;

  NetguruValuesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<NetguruValue>>> getAll() async {
    try {
      final localValue = await dataSource.getAll();
      return Right(localValue);
    } on MemoryException {
      return Left(MemoryFailure());
    }
  }

  @override
  Future<Either<Failure, NetguruValue>> getRandom() async {
    try {
      final localValue = await dataSource.getRandom();
      return Right(localValue);
    } on MemoryException {
      return Left(MemoryFailure());
    }
  }

  @override
  Future<Either<Failure, NetguruValue>> getRandomFavorite() async {
    try {
      final localValue = await dataSource.getRandomFavorite();
      return Right(localValue);
    } on MemoryException {
      return Left(MemoryFailure());
    }
  }

  @override
  Future<Either<Failure, NetguruValue>> put(NetguruValue value) async {
    try {
      final NetguruValue savedValue = await dataSource.put(value.toModel());
      return Right(savedValue);
    } on MemoryException {
      return Left(MemoryFailure());
    }
  }
}
