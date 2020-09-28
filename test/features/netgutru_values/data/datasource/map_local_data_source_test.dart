import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:netguru_values/core/error/exceptions.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/netguru_values_local_datasource.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';

void main() {
  group('get all Values', () {
    MapLocalDataSource tested;
    test(
      'should return all stored Values',
      () async {
        //given
        tested = MapLocalDataSource(defaultStorage);
        // when
        List<NetguruValueModel> actual = await tested.getAll();

        // then
        expect(actual.length, equals(defaultStorage.length));
      },
    );
  });

  group('get random Value', () {
    MapLocalDataSource tested;
    NetguruValueModel value = NetguruValueModel(
        id: 1,
        text: "Exceed clients' and colleagues' expectations",
        isFavorite: false);

    test(
      'should return one Value',
      () async {
        //given
        tested = MapLocalDataSource(HashMap.of({1: value}));
        // when
        NetguruValueModel actual = await tested.getRandom();

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
    NetguruValueModel value = NetguruValueModel(
        id: 1,
        text: "Exceed clients' and colleagues' expectations",
        isFavorite: false);
    NetguruValueModel favoriteValue = NetguruValueModel(
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
        NetguruValueModel actual = await tested.getRandomFavorite();

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
    NetguruValueModel existingValue = NetguruValueModel(
        id: 1,
        text: "Exceed clients' and colleagues' expectations",
        isFavorite: false);

    test(
      'should add new value',
      () async {
        //given
        NetguruValueModel newValue = NetguruValueModel(
            id: null,
            text:
                "Take ownership and question the status quo in a constructive manner",
            isFavorite: true);
        var source = HashMap.of({1: existingValue});
        tested = MapLocalDataSource(source);
        // when
        NetguruValueModel actual = await tested.put(newValue);

        // then
        expect(actual.id, equals(2));
        expect(source.length, equals(2));
      },
    );

    test(
      'should update existing value',
      () async {
        //given
        NetguruValueModel updateExisting = NetguruValueModel(
            id: 1,
            text: "Exceed clients' and colleagues' expectations",
            isFavorite: true);
        var source = HashMap.of({1: existingValue});
        tested = MapLocalDataSource(source);
        // when
        NetguruValueModel actual = await tested.put(updateExisting);

        // then
        expect(actual, equals(updateExisting));
        expect(actual.isFavorite, equals(true));
        expect(source.length, equals(1));
      },
    );
  });
}
