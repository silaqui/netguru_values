import 'package:flutter_test/flutter_test.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';

void main() {
  const testModel = NetguruValueModel(id: 1, text: 'Test Text');

  test(
    'should be a subclass of NetguruValue entity',
    () async {
      // then
      expect(testModel, isA<NetguruValue>());
    },
  );

  test(
    'should toMap',
    () async {
      //when
      final Map<String, dynamic> actual = testModel.toMap();

      // then
      expect(actual['id'], 1);
      expect(actual['valueText'], 'Test Text');
      expect(actual['isFavorite'], 0);
      expect(actual['isDefault'], 0);
    },
  );

  test(
    'should fromMap',
    () async {
      //given
      final Map<String, dynamic> input = {
        'id': 5,
        'valueText': 'Test Text',
        'isFavorite': 1,
        'isDefault': 1
      };
      //when
      final NetguruValueModel actual = NetguruValueModel.fromMap(input);

      // then
      expect(actual.id, 1);
      expect(actual.text, 'Test Text');
      expect(actual.isFavorite, true);
      expect(actual.isDefault, true);
    },
  );
}
