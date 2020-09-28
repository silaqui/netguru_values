import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/add_value/add_value_bloc.dart';

import 'use_cases_mocks.dart';

void main() {
  AddValueBloc tested;

  MockPutNetguruValue putNetguruValue;

  setUp(() {
    putNetguruValue = MockPutNetguruValue();

    tested = AddValueBloc(putNetguruValue);
  });

  test('initial state should be Initial', () {
    // then
    expect(tested.state, equals(Initial()));
  });

  group('SaveNewValueEvent', () {
    final testValue = NetguruValueModel(text: 'test');
    final savedTestValue = NetguruValue(id: 1, text: 'test');

    test(
      'should save new value using use case',
      () async {
        // given
        when(putNetguruValue(testValue))
            .thenAnswer((_) async => Right(savedTestValue));
        // when
        tested.add(SaveNewValueEvent('test'));
        // then
        await untilCalled(putNetguruValue(any));
        verify(putNetguruValue(testValue));
      },
    );

    test(
      'should emit [Saving, Saved] when data is gotten successfully',
      () async {
        // given
        final expected = [
          Saving(),
          Saved(),
        ];
        when(putNetguruValue(any)).thenAnswer((_) async => Right(testValue));
        // when
        tested.add(SaveNewValueEvent('test'));
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Saving, Error] when getting data fails',
      () async {
        // given
        final expected = [
          Saving(),
          Error(message: MEMORY_FAILURE_MESSAGE),
        ];
        when(putNetguruValue(any))
            .thenAnswer((_) async => Left(MemoryFailure()));
        // when
        tested.add(SaveNewValueEvent('test'));
        // then
        expectLater(tested, emitsInOrder(expected));
      },
    );
  });
}
