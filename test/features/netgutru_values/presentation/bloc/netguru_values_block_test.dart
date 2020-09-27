import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_all_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_favorite_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/put_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/toggle_favorite_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values_bloc.dart';

class MockGetAllNetguruValue extends Mock implements GetAllNetguruValue {}

class MockGetRandomNetguruValue extends Mock implements GetRandomNetguruValue {}

class MockGetRandomFavoriteNetguruValue extends Mock
    implements GetRandomFavoriteNetguruValue {}

class MockPutNetguruValue extends Mock implements PutNetguruValue {}

class MockToggleFavoriteNetguruValue extends Mock
    implements ToggleFavoriteNetguruValue {}

void main() {
  NetguruValuesBloc tested;

  MockGetAllNetguruValue getAll;
  MockGetRandomNetguruValue getRandom;
  MockGetRandomFavoriteNetguruValue getRandomFavorite;
  MockPutNetguruValue put;
  MockToggleFavoriteNetguruValue toggleFavorite;

  setUp(() {
    getAll = MockGetAllNetguruValue();
    getRandom = MockGetRandomNetguruValue();
    getRandomFavorite = MockGetRandomFavoriteNetguruValue();
    put = MockPutNetguruValue();
    toggleFavorite = MockToggleFavoriteNetguruValue();

    tested = NetguruValuesBloc(
        getAll, getRandom, getRandomFavorite, put, toggleFavorite);
  });

  test('initial state should be Initial', () {
    // then
    expect(tested.state, equals(Initial()));
  });

  group('GetRandomNetguruValueEvent', () {
    final testValue = NetguruValue(id: 1, text: 'test', isFavorite: false);

    test(
      'should get data from the random use case',
      () async {
        // given
        when(getRandom(NoParams())).thenAnswer((_) async => Right(testValue));
        // when
        tested.add(GetRandomNetguruValueEvent());
        // then
        await untilCalled(getRandom(any));
        verify(getRandom(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // given
        final expected = [
          Loading(),
          Loaded(value: testValue),
        ];
        when(getRandom(any)).thenAnswer((_) async => Right(testValue));
        // when
        tested.add(GetRandomNetguruValueEvent());
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // given
        final expected = [
          Loading(),
          Error(message: MEMORY_FAILURE_MESSAGE),
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
    final testValue = NetguruValue(id: 1, text: 'test', isFavorite: true);

    test(
      'should get data from the random favorite use case',
      () async {
        // given
        when(getRandomFavorite(NoParams()))
            .thenAnswer((_) async => Right(testValue));
        // when
        tested.add(GetRandomFavoriteNetguruValueEvent());
        // then
        await untilCalled(getRandomFavorite(any));
        verify(getRandomFavorite(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // given
        final expected = [
          Loading(),
          Loaded(value: testValue),
        ];
        when(getRandomFavorite(any)).thenAnswer((_) async => Right(testValue));
        // when
        tested.add(GetRandomFavoriteNetguruValueEvent());
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // given
        final expected = [
          Loading(),
          Error(message: MEMORY_FAILURE_MESSAGE),
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

  group('GetAllNetguruValuesEvent', () {
    final testValue = [NetguruValue(id: 1, text: 'test', isFavorite: true)];

    test(
      'should get data from the get all use case',
      () async {
        // given
        when(getAll(NoParams())).thenAnswer((_) async => Right(testValue));
        // when
        tested.add(GetAllNetguruValuesEvent());
        // then
        await untilCalled(getAll(any));
        verify(getAll(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // given
        final expected = [
          Loading(),
          LoadedList(value: testValue),
        ];
        when(getAll(any)).thenAnswer((_) async => Right(testValue));
        // when
        tested.add(GetAllNetguruValuesEvent());
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // given
        final expected = [
          Loading(),
          Error(message: MEMORY_FAILURE_MESSAGE),
        ];
        when(getAll(any)).thenAnswer((_) async => Left(MemoryFailure()));
        // when
        tested.add(GetAllNetguruValuesEvent());
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );
  });

  group('AddNetguruValuesEvent', () {
    final testValue = NetguruValue(id: null, text: 'test', isFavorite: true);
    final testSavedValue = NetguruValue(id: 1, text: 'test', isFavorite: true);

    test(
      'should add data with add use case',
      () async {
        // given
        when(put(testValue)).thenAnswer((_) async => Right(testSavedValue));
        // when
        tested.add(AddNetguruValuesEvent(testValue));
        // then
        await untilCalled(put(any));
        verify(put(testValue));
      },
    );

    test(
      'should emit [Loading, Updated] when data is putted successfully',
      () async {
        // given
        final expected = [
          Loading(),
          Updated(value: testSavedValue),
        ];
        when(put(any)).thenAnswer((_) async => Right(testSavedValue));
        // when
        tested.add(AddNetguruValuesEvent(testValue));
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading, Error] when putting data fails',
      () async {
        // given
        final expected = [
          Loading(),
          Error(message: MEMORY_FAILURE_MESSAGE),
        ];
        when(put(any)).thenAnswer((_) async => Left(MemoryFailure()));
        // when
        tested.add(AddNetguruValuesEvent(testValue));
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );
  });

  group('UpdateNetguruValuesEvent', () {
    final testValue = NetguruValue(id: 1, text: 'test', isFavorite: false);
    final testUpdatedValue =
        NetguruValue(id: 1, text: 'test', isFavorite: true);

    test(
      'should toggle favorite with toggle favorite use case',
      () async {
        // given
        when(toggleFavorite(testValue))
            .thenAnswer((_) async => Right(testUpdatedValue));
        // when
        tested.add(ToggleFavoriteNetguruValuesEvent(testValue));
        // then
        await untilCalled(toggleFavorite(any));
        verify(toggleFavorite(testValue));
      },
    );

    test(
      'should emit [Loading, Updated] when data is putted successfully',
      () async {
        // given
        final expected = [
          Loading(),
          Updated(value: testUpdatedValue),
        ];
        when(put(any)).thenAnswer((_) async => Right(testUpdatedValue));
        // when
        tested.add(AddNetguruValuesEvent(testValue));
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading, Error] when toggling favorite fails',
      () async {
        // given
        final expected = [
          Loading(),
          Error(message: MEMORY_FAILURE_MESSAGE),
        ];
        when(put(any)).thenAnswer((_) async => Left(MemoryFailure()));
        // when
        tested.add(AddNetguruValuesEvent(testValue));
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );
  });
}
