import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/repositories/netguru_values_repository.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_netguru_value.dart';

class MockNetguruValuesRepository extends Mock
    implements NetguruValuesRepository {}

void main() {
  GetRandomNetguruValue tested;
  MockNetguruValuesRepository mockRepository;

  setUp(() {
    mockRepository = MockNetguruValuesRepository();
    tested = GetRandomNetguruValue(mockRepository);
  });

  final testValue = NetguruValue(id: 1, text: 'test', isFavorite: false);

  test(
    'should get the Value from the repository',
    () async {
      // given
      when(mockRepository.getRandom())
          .thenAnswer((_) async => Right(testValue));
      // when
      final actual = await tested(NoParams());
      // then
      expect(actual, Right(testValue));
      verify(mockRepository.getRandom());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
