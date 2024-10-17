import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/model/Posto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibe_candidaturas/config.dart';


Future <List<Posto>>? getPostos() async{
  List <Posto> postos = [];
    try {
    var url = Uri.http(IP, '/api/Posto');
    var response = await http.get(url).timeout(const Duration(seconds: 30));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Decode JSON response
      var responseBody = jsonDecode(response.body) as List<dynamic>;
      print('Decoded response body: $responseBody');

      // Convert JSON list to list of Area objects
      postos = responseBody.map((data) {
        print('Mapping data: $data');
        return Posto.fromJson(data as Map<String, dynamic>);
      }).toList();

      print("Areas fetched: ${postos.length}");

      // Save data to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Postos', jsonEncode(responseBody));
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return postos;
}