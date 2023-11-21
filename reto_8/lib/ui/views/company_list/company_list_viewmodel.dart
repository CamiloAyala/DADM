import 'package:reto_8/app/app.locator.dart';
import 'package:reto_8/app/app.router.dart';
import 'package:reto_8/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:reto_8/models/company_model.dart';
import 'package:stacked_services/stacked_services.dart';

class CompanyListViewModel extends BaseViewModel {

  final DatabaseService _databaseService = locator<DatabaseService>();
  final _navigationService = locator<NavigationService>();

  List<Company> companies = [];
  bool isLoading = false;

  void navigateToCompanyForm() {
    _navigationService.navigateTo(Routes.companyFormView);
  }

  void reload(){
    _navigationService.clearStackAndShow(Routes.companyListView);
  }

  Future<List<Company>> getCompanies() async {
    companies = await _databaseService.getCompanies();
    return companies;
  }

  Future<int> deleteCompany(int id) async {
    isLoading = true;
    int deleteCount = await _databaseService.deleteCompany(id);

    isLoading = false;
    notifyListeners();

    return deleteCount;
  }

}