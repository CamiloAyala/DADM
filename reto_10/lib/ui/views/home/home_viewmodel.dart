import 'package:flutter/material.dart';
import 'package:reto_10/app/app.locator.dart';
import 'package:reto_10/services/open_data_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final OpenDataService _openDataService = locator<OpenDataService>();

  final TextEditingController yearController = TextEditingController();
  final TextEditingController quarterController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController tecnologyController = TextEditingController();
  final TextEditingController segmentController = TextEditingController();

  int year = 0;
  int quarter = 0;
  String name = '';
  String tecnology = '';
  String segment = '';

  changeYear(String value) {
    if(value == '') value = '0';
    year = int.parse(value);
    notifyListeners();
  }

  changeQuarter(String value) {
    if(value == '') value = '0';
    quarter = int.parse(value);
    notifyListeners();
  }

  changeName(String value) {
    name = value;
    notifyListeners();
  }

  changeTecnology(String value) {
    tecnology = value;
    notifyListeners();
  }

  changeSegment(String value) {
    segment = value;
    notifyListeners();
  }

  void cleanValues(){
    year = 0;
    quarter = 0;
    name = '';
    tecnology = '';
    segment = '';

    yearController.clear();
    quarterController.clear();
    nameController.clear();
    tecnologyController.clear();
    segmentController.clear();
    
    notifyListeners();
  }

  int get getYear => year;
  int get getQuarter => quarter;
  String get getName => name;
  String get getTecnology => tecnology;
  String get getSegment => segment;

  Future<List<dynamic>> getOpenData() async {
    return await _openDataService.getOpenData(
        year: getYear,
        quarter: getQuarter,
        name: getName,
        tecnology: getTecnology,
        segment: getSegment);
  }
}
