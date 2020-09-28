import 'package:meta/meta.dart';
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
}
