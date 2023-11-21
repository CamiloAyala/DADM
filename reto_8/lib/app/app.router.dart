// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i5;
import 'package:flutter/material.dart';
import 'package:reto_8/models/company_model.dart' as _i6;
import 'package:reto_8/ui/views/company_details/company_details_view.dart'
    as _i4;
import 'package:reto_8/ui/views/company_form/company_form_view.dart' as _i3;
import 'package:reto_8/ui/views/company_list/company_list_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i7;

class Routes {
  static const companyListView = '/';

  static const companyFormView = '/create-company';

  static const companyDetailsView = '/company';

  static const all = <String>{
    companyListView,
    companyFormView,
    companyDetailsView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.companyListView,
      page: _i2.CompanyListView,
    ),
    _i1.RouteDef(
      Routes.companyFormView,
      page: _i3.CompanyFormView,
    ),
    _i1.RouteDef(
      Routes.companyDetailsView,
      page: _i4.CompanyDetailsView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.CompanyListView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.CompanyListView(),
        settings: data,
      );
    },
    _i3.CompanyFormView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.CompanyFormView(),
        settings: data,
      );
    },
    _i4.CompanyDetailsView: (data) {
      final args = data.getArgs<CompanyDetailsViewArguments>(nullOk: false);
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.CompanyDetailsView(key: args.key, company: args.company),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class CompanyDetailsViewArguments {
  const CompanyDetailsViewArguments({
    this.key,
    required this.company,
  });

  final _i5.Key? key;

  final _i6.Company company;

  @override
  String toString() {
    return '{"key": "$key", "company": "$company"}';
  }

  @override
  bool operator ==(covariant CompanyDetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.company == company;
  }

  @override
  int get hashCode {
    return key.hashCode ^ company.hashCode;
  }
}

extension NavigatorStateExtension on _i7.NavigationService {
  Future<dynamic> navigateToCompanyListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.companyListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCompanyFormView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.companyFormView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCompanyDetailsView({
    _i5.Key? key,
    required _i6.Company company,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.companyDetailsView,
        arguments: CompanyDetailsViewArguments(key: key, company: company),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCompanyListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.companyListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCompanyFormView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.companyFormView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCompanyDetailsView({
    _i5.Key? key,
    required _i6.Company company,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.companyDetailsView,
        arguments: CompanyDetailsViewArguments(key: key, company: company),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
