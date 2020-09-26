import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NetguruValue extends Equatable {
  final int id;
  final String text;
  final bool isFavorite;

  NetguruValue({
    @required this.id,
    @required this.text,
    @required this.isFavorite,
  });

  @override
  List<Object> get props => [id, text, isFavorite];
}
