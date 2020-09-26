import 'package:dartz/dartz.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/repositories/netguru_values_repository.dart';

class ToggleFavoriteNetguruValue
    implements UseCase<NetguruValue, NetguruValue> {
  final NetguruValuesRepository repository;

  ToggleFavoriteNetguruValue(this.repository);

  @override
  Future<Either<Failure, NetguruValue>> call(NetguruValue params) async {
    var newValue = NetguruValue(
        id: params.id, text: params.text, isFavorite: params.isFavorite);
    return await repository.put(newValue);
  }
}
