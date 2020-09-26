import 'package:flutter_test/flutter_test.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';

void main() {
  final testModel =
      NetguruValueModel(id: 1, text: 'Test Text', isFavorite: false);

  test(
    'should be a subclass of NetguruValue entity',
    () async {
      // then
      expect(testModel, isA<NetguruValue>());
    },
  );
}
