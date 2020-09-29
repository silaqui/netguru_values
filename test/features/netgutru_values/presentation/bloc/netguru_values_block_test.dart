import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';

import 'file:///C:/git/netguru_values/lib/features/netguru_values/presentation/bloc/netguru_values/netguru_values_bloc.dart';

import 'use_cases_mocks.dart';

void main() {
  NetguruValuesBloc tested;

  MockGetRandomNetguruValue getRandom;
  MockGetRandomFavoriteNetguruValue getRandomFavorite;
  MockToggleFavoriteNetguruValue toggleFavoriteNetguruValue;

  setUp(() {
    getRandom = MockGetRandomNetguruValue();
    getRandomFavorite = MockGetRandomFavoriteNetguruValue();

    tested = NetguruValuesBloc(
        getRandom, getRandomFavorite, toggleFavoriteNetguruValue);
  });

  test('initial state should be Initial', () {
    // then
    expect(tested.state, equals(Initial()));
  });

  group('GetRandomNetguruValueEvent', () {
    const testValue = NetguruValue(id: 1, text: 'test');

    test(
      'should get data from the random use case',
      () async {
        // given
        when(getRandom(NoParams()))
            .thenAnswer((_) async => const Right(testValue));
        // when
        tested.add(GetRandomNetguruValueEvent());
        // then
        await untilCalled(getRandom(any));
        verify(getRandom(NoParams()));
      },
    );

    test(
      'should emit [Loading Loaded] when data is gotten successfully',
      () async {
        // given
        final expected = [
          Loading(),
          Loaded(value: testValue),
        ];
        when(getRandom(any)).thenAnswer((_) async => const Right(testValue));
        // when
        tested.add(GetRandomNetguruValueEvent());
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading Error] when getting data fails',
          () async {
        // given
        final expected = [
          Loading(),
          Error(message: memoryFailureMessage),
        ];
        when(getRandom(any)).thenAnswer((_) async => Left(MemoryFailure()));
        // when
        tested.add(GetRandomNetguruValueEvent());
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );
  });

  group('GetRandomFavoriteNetguruValueEvent', () {
    const testValue = NetguruValue(id: 1, text: 'test', isFavorite: true);

    test(
      'should get data from the random favorite use case',
          () async {
        // given
        when(getRandomFavorite(NoParams()))
            .thenAnswer((_) async => const Right(testValue));
        // when
        tested.add(GetRandomFavoriteNetguruValueEvent());
        // then
        await untilCalled(getRandomFavorite(any));
        verify(getRandomFavorite(NoParams()));
      },
    );

    test(
      'should emit [Loading Loaded] when data is gotten successfully',
          () async {
        // given
        final expected = [
          Loading(),
          Loaded(value: testValue),
        ];
        when(getRandomFavorite(any))
            .thenAnswer((_) async => const Right(testValue));
        // when
        tested.add(GetRandomFavoriteNetguruValueEvent());
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading Error] when getting data fails',
          () async {
        // given
        final expected = [
          Loading(),
          Error(message: memoryFailureMessage),
        ];
        when(getRandomFavorite(any))
            .thenAnswer((_) async => Left(MemoryFailure()));
        // when
        tested.add(GetRandomFavoriteNetguruValueEvent());
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );
  });
}
