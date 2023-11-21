import 'package:reto_8/services/database_service.dart';
import 'package:reto_8/ui/views/company_details/company_details_view.dart';
import 'package:reto_8/ui/views/company_form/company_form_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:reto_8/ui/views/company_list/company_list_view.dart';

@StackedApp(

  routes: [
    MaterialRoute(page: CompanyListView, path: '/'),
    MaterialRoute(page: CompanyFormView, path: '/create-company'),
    MaterialRoute(page: CompanyDetailsView, path: '/company'),
  ],

  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DatabaseService)
  ]

)

class AppSetup {}