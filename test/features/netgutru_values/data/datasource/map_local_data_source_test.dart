import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:netguru_values/core/error/exceptions.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/core_values.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/map_local_data_source.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';

void main() {
  group('get all Values', () {
    MapLocalDataSource tested;
    test(
      'should return all stored Values',
      () async {
        //given
        tested = MapLocalDataSource(coreValues);
        // when
        final List<NetguruValueModel> actual = await tested.getAll();

        // then
        expect(actual.length, equals(coreValues.length));
      },
    );
  });

  group('get random Value', () {
    MapLocalDataSource tested;
    const NetguruValueModel value = NetguruValueModel(
        id: 1, text: "Exceed clients' and colleagues' expectations");

    test(
      'should return one Value',
      () async {
        //given
        tested = MapLocalDataSource(HashMap.of({1: value}));
        // when
        final NetguruValueModel actual = await tested.getRandom();

        // then
        expect(actual, equals(value));
      },
    );

    test(
      'should throw MemoryException when storage is empty',
      () async {
        //given
        tested = MapLocalDataSource(HashMap<int, NetguruValueModel>());
        // when

        // then
        expect(() => tested.getRandom(),
            throwsA(const TypeMatcher<MemoryException>()));
      },
    );
  });

  group('get random favorite Value', () {
    MapLocalDataSource tested;
    const NetguruValueModel value = NetguruValueModel(
        id: 1,
        text: "Exceed clients' and colleagues' expectations");
    const NetguruValueModel favoriteValue = NetguruValueModel(
        id: 2,
        text:
        "Take ownership and question the status quo in a constructive manner",
        isFavorite: true);

    test(
      'should return one favorite Value at random',
          () async {
        //given
        tested = MapLocalDataSource(HashMap.of({1: value, 2: favoriteValue}));
        // when
        final NetguruValueModel actual = await tested.getRandomFavorite();

        // then
        expect(actual, equals(favoriteValue));
      },
    );

    test(
      'should throw MemoryException when have no favorite values',
      () async {
        //given
        tested = MapLocalDataSource(HashMap.of({1: value, 2: value}));
        // when

        // then
        expect(() => tested.getRandomFavorite(),
            throwsA(const TypeMatcher<MemoryException>()));
      },
    );
  });

  group('put Value', () {
    MapLocalDataSource tested;
    const NetguruValueModel existingValue = NetguruValueModel(
        id: 1,
        text: "Exceed clients' and colleagues' expectations");

    test(
      'should add new value',
          () async {
        //given
        const NetguruValueModel newValue = NetguruValueModel(
            text:
            "Take ownership and question the status quo in a constructive manner",
            isFavorite: true);
        final source = HashMap.of({1: existingValue});
        tested = MapLocalDataSource(source);
        // when
        await tested.put(newValue);

        // then
        expect(source.length, equals(2));
      },
    );

    test(
      'should update existing value',
      () async {
        //given
        const NetguruValueModel updateExisting = NetguruValueModel(
            id: 1,
            text: "Exceed clients' and colleagues' expectations",
            isFavorite: true);
        final source = HashMap.of({1: existingValue});
        tested = MapLocalDataSource(source);
        // when
        tested.put(updateExisting);

        // then
        expect(source.length, equals(1));
        expect(source[1].isFavorite, equals(true));
      },
    );
  });
}
