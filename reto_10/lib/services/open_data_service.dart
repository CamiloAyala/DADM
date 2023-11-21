import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenDataService {
  /// https://www.datos.gov.co/Ciencia-Tecnolog-a-e-Innovaci-n/Internet-M-vil-abonados-por-proveedor/ezyw-egbj
  static const String _baseUrl =
      'https://www.datos.gov.co/resource/ezyw-egbj.json';

  Future<List<dynamic>> getOpenData(
      {required int year,
      required int quarter,
      required String name,
      required String tecnology,
      required String segment}) async {
    
    final query = queryParams(
        year: year,
        quarter: quarter,
        name: name,
        tecnology: tecnology,
        segment: segment);
    final response = await http.get(Uri.parse(_baseUrl + query));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  String queryParams(
      {required int year,
      required int quarter,
      required String name,
      required String tecnology,
      required String segment}) {
    String query = '?';

    if (year != 0) {
      query += 'a_o=$year&';
    }

    if (quarter != 0) {
      query += 'trimestre=$quarter&';
    }

    if (name != '') {
      query += 'proveedor=$name&';
    }

    if (tecnology != '') {
      query += 'tecnolog_a=$tecnology&';
    }

    if (segment != '') {
      query += 'segmento=$segment&';
    }

    return query;
  }
}
