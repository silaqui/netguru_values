import 'package:meta/meta.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';

class NetguruValueModel extends NetguruValue {
  NetguruValueModel({
    @required int id,
    @required String text,
    @required bool isFavorite,
    bool isDefault = false,
  }) : super(
          id: id,
          text: text,
          isFavorite: isFavorite,
          isDefault: isDefault,
        );
}
