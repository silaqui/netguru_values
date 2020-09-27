// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../netguru_values/presentation/page/add_value_page.dart';
import '../netguru_values/presentation/page/netguru_values_list_page.dart';
import '../netguru_values/presentation/page/netguru_values_page.dart';

class Routes {
  static const String netguruValuesPage = '/';
  static const String netguruValuesListPage = '/netguru-values-list-page';
  static const String addValuePage = '/add-value-page';
  static const all = <String>{
    netguruValuesPage,
    netguruValuesListPage,
    addValuePage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.netguruValuesPage, page: NetguruValuesPage),
    RouteDef(Routes.netguruValuesListPage, page: NetguruValuesListPage),
    RouteDef(Routes.addValuePage, page: AddValuePage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    NetguruValuesPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NetguruValuesPage(),
        settings: data,
      );
    },
    NetguruValuesListPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NetguruValuesListPage(),
        settings: data,
      );
    },
    AddValuePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddValuePage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushNetguruValuesPage() =>
      push<dynamic>(Routes.netguruValuesPage);

  Future<dynamic> pushNetguruValuesListPage() =>
      push<dynamic>(Routes.netguruValuesListPage);

  Future<dynamic> pushAddValuePage() => push<dynamic>(Routes.addValuePage);
}
