import 'package:meta/meta.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/persistent_data_source.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';

class NetguruValueModel extends NetguruValue {
  NetguruValueModel({
    int id,
    @required String text,
    bool isFavorite = false,
    bool isDefault = false,
  }) : super(
          id: id,
          text: text,
          isFavorite: isFavorite,
          isDefault: isDefault,
        );

  Map<String, dynamic> toMap() {
    return {
      PersistentDataSource.columnId: id,
      PersistentDataSource.columnText: text,
      PersistentDataSource.columnFavorite: isFavorite ? 1 : 0,
      PersistentDataSource.columnDefault: isDefault ? 1 : 0,
    };
  }

  factory NetguruValueModel.fromMap(Map<String, dynamic> map) {
    return NetguruValueModel(
      id: map[PersistentDataSource.columnId],
      text: map[PersistentDataSource.columnText],
      isFavorite: map[PersistentDataSource.columnFavorite] == 1,
      isDefault: map[PersistentDataSource.columnDefault] == 1,
    );
  }
}
