import 'package:reto_8/app/app.locator.dart';
import 'package:reto_8/app/app.router.dart';
import 'package:reto_8/models/company_model.dart';
import 'package:reto_8/models/company_type.dart';
import 'package:reto_8/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CompanyFormViewModel extends BaseViewModel {

  final DatabaseService _databaseService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String name = '';
  String website = '';
  String phone = '';
  String email = '';
  String products = '';
  String type = '';

  List<String> companyTypes = [
    'Consultoría',
    'Software',
  ];

  changeName(String value) {
    name = value;
    notifyListeners();
  }

  changeWebsite(String value) {
    website = value;
    notifyListeners();
  }

  changePhone(String value) {
    phone = value;
    notifyListeners();
  }

  changeEmail(String value) {
    email = value;
    notifyListeners();
  }

  changeProducts(String value) {
    products = value;
    notifyListeners();
  }

  changeType(String? value) {
    type = value!;
    notifyListeners();
  }

  void navigateToCompanyList() {
    _navigationService.clearStackAndShow(Routes.companyListView);
  }

  Future<int> createCompany() async {
    CompanyType companyType;

    if(type == "Consultoría") {
      companyType = CompanyType.consulting;
    } else {
      companyType = CompanyType.software;
    }

    Company newCompany = Company(
      name: name,
      website: website,
      phone: phone,
      email: email,
      products: products,
      type: companyType,
    );



    int createdId = await _databaseService.addCompany(company: newCompany);

    if(createdId != -1) {
      navigateToCompanyList();
    }

    return createdId;
  }
}