import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values_list/netguru_values_list_bloc.dart';

import 'use_cases_mocks.dart';

void main() {
  NetguruValuesListBloc tested;

  MockGetAllNetguruValue getAll;
  MockToggleFavoriteNetguruValue toggleFavoriteNetguruValue;

  setUp(() {
    getAll = MockGetAllNetguruValue();

    tested = NetguruValuesListBloc(getAll, toggleFavoriteNetguruValue);
  });

  test('initial state should be Empty', () {
    // then
    expect(tested.state, equals(Empty()));
  });

  group('GetAllNetguruValuesEvent', () {
    final testValue = [
      const NetguruValue(id: 1, text: 'test', isFavorite: true)
    ];

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
      'should emit [LoadedList] when data is gotten successfully',
      () async {
        // given
        final expected = [
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
      'should emit [Error] when getting data fails',
      () async {
        // given
        final expected = [
          Error(message: memoryFailureMessage),
        ];
        when(getAll(any)).thenAnswer((_) async => Left(MemoryFailure()));
        // when
        tested.add(GetAllNetguruValuesEvent());
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );
  });
}
