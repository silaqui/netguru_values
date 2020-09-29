import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/repositories/netguru_values_repository.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_favorite_netguru_value.dart';

class MockNetguruValuesRepository extends Mock
    implements NetguruValuesRepository {}

void main() {
  GetRandomFavoriteNetguruValue tested;
  MockNetguruValuesRepository mockRepository;

  setUp(() {
    mockRepository = MockNetguruValuesRepository();
    tested = GetRandomFavoriteNetguruValue(mockRepository);
  });

  const testValue = NetguruValue(id: 1, text: 'test', isFavorite: true);

  test(
    'should get one of the favorite Value from the repository',
    () async {
      // given
      when(mockRepository.getRandomFavorite())
          .thenAnswer((_) async => const Right(testValue));
      // when
      final actual = await tested(NoParams());
      // then
      expect(actual, const Right(testValue));
      verify(mockRepository.getRandomFavorite());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
