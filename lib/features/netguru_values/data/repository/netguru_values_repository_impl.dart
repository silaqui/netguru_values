import 'package:dartz/dartz.dart';
import 'package:netguru_values/core/error/exceptions.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/netguru_values_local_datasource.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/repositories/netguru_values_repository.dart';

class NetguruValuesRepositoryImpl implements NetguruValuesRepository {
  final NetguruValuesLocalDataSource localDataSource;

  NetguruValuesRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<NetguruValue>>> getAll() async {
    try {
      final localValue = await localDataSource.getAll();
      return Right(localValue);
    } on MemoryException {
      return Left(MemoryFailure());
    }
  }

  @override
  Future<Either<Failure, NetguruValue>> getRandom() async {
    try {
      final localValue = await localDataSource.getRandom();
      return Right(localValue);
    } on MemoryException {
      return Left(MemoryFailure());
    }
  }

  @override
  Future<Either<Failure, NetguruValue>> getRandomFavorite() async {
    try {
      final localValue = await localDataSource.getRandomFavorite();
      return Right(localValue);
    } on MemoryException {
      return Left(MemoryFailure());
    }
  }

  @override
  Future<Either<Failure, NetguruValue>> put(NetguruValue value) async {
    try {
      final localValue = await localDataSource.put(value);
      return Right(localValue);
    } on MemoryException {
      return Left(MemoryFailure());
    }
  }
}
