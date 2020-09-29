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

  test(
    'should toMap',
    () async {
      //when
      Map<String, dynamic> actual = testModel.toMap();

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
      Map<String, dynamic> input = {
        'id': 5,
        'valueText': 'Test Text',
        'isFavorite': 1,
        'isDefault': 1
      };
      //when
      NetguruValueModel actual = NetguruValueModel.fromMap(input);

      // then
      expect(actual.id, 1);
      expect(actual.text, 'Test Text');
      expect(actual.isFavorite, true);
      expect(actual.isDefault, true);
    },
  );
}
