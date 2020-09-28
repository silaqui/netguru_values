import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NetguruValue extends Equatable {
  final int id;
  final String text;
  final bool isFavorite;
  final bool isDefault;

  NetguruValue({
    @required this.id,
    @required this.text,
    @required this.isFavorite,
    @required this.isDefault,
  });

  @override
  List<Object> get props => [id, text, isFavorite, isDefault];
}
