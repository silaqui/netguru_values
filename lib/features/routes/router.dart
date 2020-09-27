import 'package:auto_route/auto_route_annotations.dart';
import 'package:netguru_values/features/netguru_values/presentation/page/add_value_page.dart';
import 'package:netguru_values/features/netguru_values/presentation/page/netguru_values_list_page.dart';
import 'package:netguru_values/features/netguru_values/presentation/page/netguru_values_page.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,
    routes: <AutoRoute>[
      MaterialRoute(page: NetguruValuesPage, initial: true),
      MaterialRoute(page: NetguruValuesListPage),
      MaterialRoute(page: AddValuePage),
    ])
class $Router {}
