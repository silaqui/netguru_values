import 'dart:math';

import 'package:netguru_values/core/error/exceptions.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';

import 'netguru_values_local_datasource.dart';

class MapLocalDataSource implements NetguruValuesLocalDataSource {
  final Map<int, NetguruValueModel> storageMap;

  Random rng = Random();

  MapLocalDataSource(this.storageMap);

  @override
  Future<List<NetguruValueModel>> getAll() {
    return Future.value(storageMap.values.toList());
  }

  @override
  Future<NetguruValueModel> getRandom() {
    if (storageMap.isNotEmpty) {
      return Future.value(storageMap[rng.nextInt(storageMap.length) + 1]);
    } else {
      throw MemoryException();
    }
  }

  @override
  Future<NetguruValueModel> getRandomFavorite() {
    final List<NetguruValueModel> favorites =
        storageMap.values.toList().where((v) => v.isFavorite).toList();

    if (favorites.isNotEmpty) {
      return Future.value(favorites[rng.nextInt(favorites.length)]);
    } else {
      throw MemoryException();
    }
  }

  @override
  Future<NetguruValueModel> put(NetguruValueModel input) {
    var saveInput = input;
    if (saveInput.id == null) {
      saveInput = NetguruValueModel(
          id: storageMap.length + 1,
          text: input.text,
          isFavorite: input.isFavorite);
    }
    storageMap[saveInput.id] = saveInput;
    return Future.value(saveInput);
  }
}
