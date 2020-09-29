import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';

abstract class NetguruValuesLocalDataSource {
  Future<NetguruValueModel> getRandom();

  Future<NetguruValueModel> getRandomFavorite();

  Future<List<NetguruValueModel>> getAll();

  Future<int> put(NetguruValueModel value);
}
