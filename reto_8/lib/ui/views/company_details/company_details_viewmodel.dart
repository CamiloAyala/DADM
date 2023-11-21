import 'package:reto_8/app/app.locator.dart';
import 'package:reto_8/app/app.router.dart';
import 'package:reto_8/models/company_model.dart';
import 'package:reto_8/models/company_type.dart';
import 'package:reto_8/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CompanyDetailsViewModel extends BaseViewModel {

  final DatabaseService _databaseService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();

  int companyId = 0;
  String name = '';
  String website = '';
  String phone = '';
  String email = '';
  String products = '';
  String type = '';

  bool isDisabled = true;

  List<String> companyTypes = [
    'Consultoría',
    'Software',
  ];

  set setCompanyId(int value) {
    companyId = value;
    notifyListeners();
  }

  set setCompanyInfo(Company company) {
    name = company.name;
    website = company.website;
    phone = company.phone;
    email = company.email;
    products = company.products;
    type = company.type.name;
    notifyListeners();
  }

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

  void toggleDisabled() {
    isDisabled = !isDisabled;
    notifyListeners();
  }


  void navigateToCompanyList() {
    _navigationService.clearStackAndShow(Routes.companyListView);
  }

  Future<int> editCompany() async {
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



    int editCount = await _databaseService.updateCompany(companyId: companyId, company: newCompany);

    if(editCount != -1) {
      navigateToCompanyList();
    }

    return editCount;
  }
}