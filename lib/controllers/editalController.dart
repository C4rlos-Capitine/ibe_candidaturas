import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/model/Edital.dart';

Future<List<Edital>> getEditais() async {
  List<Edital> editais = [];
  try {
    // Use the correct IP address for localhost
    var url = Uri.http('localhost:5284', '/api/Edital');

    var response = await http.get(url).timeout(const Duration(seconds: 30));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Decode response as List of dynamic
      List<dynamic> responseBody = jsonDecode(response.body);

      // Map each item to Edital instance
      editais = responseBody.map((data) => Edital.fromJson(data)).toList();

      print("Editais fetched: ${editais.length}");
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return editais;
}

Future<Edital>? getEdital(int codedita) {
  return null;
}
