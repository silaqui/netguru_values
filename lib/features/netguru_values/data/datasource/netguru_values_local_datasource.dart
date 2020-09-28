import 'dart:collection';
import 'dart:math';

import 'package:netguru_values/core/error/exceptions.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';

abstract class NetguruValuesLocalDataSource {
  Future<NetguruValueModel> getRandom();

  Future<NetguruValueModel> getRandomFavorite();

  Future<List<NetguruValueModel>> getAll();

  Future<NetguruValueModel> put(NetguruValueModel value);
}

HashMap<int, NetguruValueModel> defaultStorage = HashMap.of({
  1: NetguruValueModel(
    id: 1,
    text: "Exceed clients' and colleagues' expectations",
    isFavorite: false,
    isDefault: true,
  ),
  2: NetguruValueModel(
    id: 2,
    text: "Take ownership and question the status quo in a constructive manner",
    isFavorite: false,
    isDefault: true,
  ),
  3: NetguruValueModel(
    id: 3,
    text:
        "Be brave, curious and experiment. Learn from all successes and failures",
    isFavorite: false,
    isDefault: true,
  ),
  4: NetguruValueModel(
    id: 4,
    text: "Act in a way that makes all of us proud",
    isFavorite: false,
    isDefault: true,
  ),
  5: NetguruValueModel(
    id: 5,
    text: "Build an inclusive, transparent and socially responsible culture",
    isFavorite: false,
    isDefault: true,
  ),
  6: NetguruValueModel(
    id: 6,
    text: "Be ambitious, grow yourself and the people around you",
    isFavorite: false,
    isDefault: true,
  ),
  7: NetguruValueModel(
    id: 7,
    text: "Recognize excellence and engagement",
    isFavorite: false,
    isDefault: true,
  ),
});

class MapLocalDataSource implements NetguruValuesLocalDataSource {
  final Map<int, NetguruValueModel> storageMap;

  var rng = new Random();

  MapLocalDataSource(this.storageMap);

  @override
  Future<List<NetguruValueModel>> getAll() {
    return Future.value(storageMap.values.toList());
  }

  @override
  Future<NetguruValueModel> getRandom() {
    if (storageMap.length > 0) {
      return Future.value(storageMap[rng.nextInt(storageMap.length) + 1]);
    } else {
      throw MemoryException();
    }
  }

  @override
  Future<NetguruValueModel> getRandomFavorite() {
    List<NetguruValueModel> favorites =
        storageMap.values.toList().where((v) => v.isFavorite).toList();

    if (favorites.length > 0) {
      return Future.value(favorites[rng.nextInt(favorites.length)]);
    } else {
      throw MemoryException();
    }
  }

  @override
  Future<NetguruValueModel> put(NetguruValueModel input) {
    if (input.id == null) {
      input = NetguruValueModel(
          id: storageMap.length + 1,
          text: input.text,
          isFavorite: input.isFavorite);
    }
    storageMap[input.id] = input;
    return Future.value(input);
  }
}
