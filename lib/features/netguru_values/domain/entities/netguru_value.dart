import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';

class NetguruValue extends Equatable {
  final int id;
  final String text;
  final bool isFavorite;
  final bool isDefault;

  const NetguruValue({
    this.id,
    @required this.text,
    this.isFavorite = false,
    this.isDefault = false,
  });

  NetguruValueModel toModel() {
    return NetguruValueModel(
      id: id,
      text: text,
      isFavorite: isFavorite,
      isDefault: isDefault,
    );
  }

  @override
  List<Object> get props => [id, text, isFavorite, isDefault];
}
