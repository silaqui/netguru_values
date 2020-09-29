import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/repositories/netguru_values_repository.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/put_netguru_value.dart';

class MockNetguruValuesRepository extends Mock
    implements NetguruValuesRepository {}

void main() {
  PutNetguruValue tested;
  MockNetguruValuesRepository mockRepository;

  setUp(() {
    mockRepository = MockNetguruValuesRepository();
    tested = PutNetguruValue(mockRepository);
  });

  final testInput = NetguruValue(id: 1, text: 'test', isFavorite: false);
  final idFromDatabase = 1;

  test(
    'should put the Value in the repository',
    () async {
      // given
      when(mockRepository.put(testInput))
          .thenAnswer((_) async => Right(idFromDatabase));
      // when
      final actual = await tested(testInput);
      // then
      expect(actual, Right(idFromDatabase));
      verify(mockRepository.put(testInput));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
