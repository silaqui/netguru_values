import 'package:mockito/mockito.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_all_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_favorite_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/get_random_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/put_netguru_value.dart';
import 'package:netguru_values/features/netguru_values/domain/usecases/toggle_favorite_netguru_value.dart';

class MockGetAllNetguruValue extends Mock implements GetAllNetguruValue {}

class MockGetRandomNetguruValue extends Mock implements GetRandomNetguruValue {}

class MockGetRandomFavoriteNetguruValue extends Mock
    implements GetRandomFavoriteNetguruValue {}

class MockPutNetguruValue extends Mock implements PutNetguruValue {}

class MockToggleFavoriteNetguruValue extends Mock
    implements ToggleFavoriteNetguruValue {}
