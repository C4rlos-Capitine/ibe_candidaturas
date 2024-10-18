import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/model/Distrito.dart'; // Atualize o caminho para o modelo correto
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibe_candidaturas/config.dart';

Future<List<Distrito>>? getDistritos() async {
  List<Distrito> distritos = [];
  try {
    var url = Uri.http(IP, '/api/Distrito'); // Atualize a URL se necessário
    var response = await http.get(url).timeout(const Duration(seconds: 30));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Decode JSON response
      var responseBody = jsonDecode(response.body) as List<dynamic>;
      print('Decoded response body: $responseBody');

      // Convert JSON list to list of Distrito objects
      distritos = responseBody.map((data) {
        print('Mapping data: $data');
        return Distrito.fromJson(data as Map<String, dynamic>);
      }).toList();

      print("Distritos fetched: ${distritos.length}");

      // Save data to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Distritos', jsonEncode(responseBody));
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return distritos;
}
Future<List<Distrito>>? getDistrito(int codProvinc) async {
  List<Distrito> distritos = [];
  print(codProvinc);
  try {
    // Construct the URL with query parameters
    var url = Uri.http(IP, '/api/Distrito/$codProvinc');
        print('Request URL: $url');
    var response = await http.get(url).timeout(const Duration(seconds: 30));


    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Decode JSON response
      var responseBody = jsonDecode(response.body) as List<dynamic>;
      print('Decoded response body: $responseBody');

      // Convert JSON list to list of Distrito objects
      distritos = responseBody.map((data) {
        print('Mapping data: $data');
        return Distrito.fromJson(data as Map<String, dynamic>);
      }).toList();

      print("Distritos fetched: ${distritos.length}");

      // Save data to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Distritos', jsonEncode(responseBody));
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return distritos;
}
