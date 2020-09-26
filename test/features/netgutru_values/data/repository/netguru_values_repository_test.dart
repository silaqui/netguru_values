import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_values/core/error/exceptions.dart';
import 'package:netguru_values/core/error/failures.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/netguru_values_local_datasource.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';
import 'package:netguru_values/features/netguru_values/data/repository/netguru_values_repository_impl.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';

class MockNetguruValuesLocalDataSource extends Mock
    implements NetguruValuesLocalDataSource {}

void main() {
  NetguruValuesRepositoryImpl tested;
  MockNetguruValuesLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockNetguruValuesLocalDataSource();
    tested = NetguruValuesRepositoryImpl(mockDataSource);
  });

  group(
    'get all NetguruValues',
    () {
      final List<NetguruValueModel> allValuesModels = [];
      final List<NetguruValue> allValues = allValuesModels;

      test(
        'should succeed using local data source',
        () async {
          // given
          when(mockDataSource.getAll())
              .thenAnswer((_) async => allValuesModels);
          // when
          final actual = await tested.getAll();
          // then
          expect(actual, equals(Right(allValues)));
          verify(mockDataSource.getAll());
          verifyNoMoreInteractions(mockDataSource);
        },
      );
      test(
        'should fail using local data source',
        () async {
          // given
          when(mockDataSource.getAll()).thenThrow(MemoryException());
          // when
          final actual = await tested.getAll();
          // then
          expect(actual, equals(Left(MemoryFailure())));
          verify(mockDataSource.getAll());
          verifyNoMoreInteractions(mockDataSource);
        },
      );
    },
  );

  group(
    'get random NetguruValues',
    () {
      final NetguruValueModel valueModel =
          NetguruValueModel(id: 2, text: 'Take o ...', isFavorite: false);
      final NetguruValue value = valueModel;

      test(
        'should succeed using local data source',
        () async {
          // given
          when(mockDataSource.getRandom()).thenAnswer((_) async => valueModel);
          // when
          final actual = await tested.getRandom();
          // then
          expect(actual, equals(Right(value)));
          verify(mockDataSource.getRandom());
          verifyNoMoreInteractions(mockDataSource);
        },
      );
      test(
        'should fail using local data source',
        () async {
          // given
          when(mockDataSource.getRandom()).thenThrow(MemoryException());
          // when
          final actual = await tested.getRandom();
          // then
          expect(actual, equals(Left(MemoryFailure())));
          verify(mockDataSource.getRandom());
          verifyNoMoreInteractions(mockDataSource);
        },
      );
    },
  );

  group(
    'get random favorite NetguruValues',
    () {
      final NetguruValueModel favoriteValueModel =
          NetguruValueModel(id: 1, text: 'Exceed ...', isFavorite: true);
      final NetguruValue favoriteValue = favoriteValueModel;

      test(
        'should succeed using local data source',
        () async {
          // given
          when(mockDataSource.getRandomFavorite())
              .thenAnswer((_) async => favoriteValueModel);
          // when
          final actual = await tested.getRandomFavorite();
          // then
          expect(actual, equals(Right(favoriteValue)));
          verify(mockDataSource.getRandomFavorite());
          verifyNoMoreInteractions(mockDataSource);
        },
      );
      test(
        'should fail using local data source',
        () async {
          // given
          when(mockDataSource.getRandomFavorite()).thenThrow(MemoryException());
          // when
          final actual = await tested.getRandomFavorite();
          // then
          expect(actual, equals(Left(MemoryFailure())));
          verify(mockDataSource.getRandomFavorite());
          verifyNoMoreInteractions(mockDataSource);
        },
      );
    },
  );

  group(
    'get put NetguruValues',
    () {
      final NetguruValue input =
          NetguruValueModel(id: null, text: 'Be bra ...', isFavorite: false);
      final NetguruValueModel newValueInDataSource =
          NetguruValueModel(id: 3, text: 'Be bra ...', isFavorite: false);
      final NetguruValue output = newValueInDataSource;

      test(
        'should succeed using local data source',
        () async {
          // given
          when(mockDataSource.put(input))
              .thenAnswer((_) async => newValueInDataSource);
          // when
          final actual = await tested.put(input);
          // then
          expect(actual, equals(Right(output)));
          verify(mockDataSource.put(input));
          verifyNoMoreInteractions(mockDataSource);
        },
      );
      test(
        'should fail using local data source',
        () async {
          // given
          when(mockDataSource.put(input)).thenThrow(MemoryException());
          // when
          final actual = await tested.put(input);
          // then
          expect(actual, equals(Left(MemoryFailure())));
          verify(mockDataSource.put(input));
          verifyNoMoreInteractions(mockDataSource);
        },
      );
    },
  );
}
