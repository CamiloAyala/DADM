import 'package:reto_8/models/company_type.dart';


class Company {

  final int id;
  final String name;
  final String website;
  final String phone;
  final String email;
  final String products;
  final CompanyType type;

  Company({
    this.id = 0,
    required this.name,
    required this.website,
    required this.phone,
    required this.email,
    required this.products,
    required this.type,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'website': website,
      'phone': phone,
      'email': email,
      'products': products,
      'type': type.name,
    };
  }

}