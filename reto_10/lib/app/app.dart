import 'package:reto_10/services/open_data_service.dart';
import 'package:reto_10/ui/views/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, path: '/')
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: OpenDataService)
  ]
)


class AppSetup {}