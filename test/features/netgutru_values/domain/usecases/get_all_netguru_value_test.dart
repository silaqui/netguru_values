import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:netguru_values/core/usecases/usecase.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/repositories/netguru_values_repository.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_all_netguru_value.dart';

class MockNetguruValuesRepository extends Mock
    implements NetguruValuesRepository {}

void main() {
  GetAllNetguruValue tested;
  MockNetguruValuesRepository mockRepository;

  setUp(() {
    mockRepository = MockNetguruValuesRepository();
    tested = GetAllNetguruValue(mockRepository);
  });

  final testValue = [NetguruValue(id: 1, text: 'test', isFavorite: true)];

  test(
    'should get all ot the Values from the repository',
    () async {
      // given
      when(mockRepository.getAll()).thenAnswer((_) async => Right(testValue));
      // when
      final actual = await tested(NoParams());
      // then
      expect(actual, Right(testValue));
      verify(mockRepository.getAll());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
