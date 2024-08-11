import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/model/provincia.dart';

Future<List<Provincia>> getProvincias() async {
  List<Provincia> provincia = [];
  try {
    var url = Uri.http(IP, '/api/Provincia');

    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Decode response as List of dynamic
      List<dynamic> responseBody = jsonDecode(response.body);

      // Map each item to Edital instance
      provincia = responseBody.map((data) => Provincia.fromJson(data)).toList();

      print("Editais fetched: ${provincia}");
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return provincia;
}
