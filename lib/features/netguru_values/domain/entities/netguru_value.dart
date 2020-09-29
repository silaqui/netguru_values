import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

  @override
  List<Object> get props => [id, text, isFavorite, isDefault];
}
