import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/model/Area.dart';

Future<List<Area>>? getAreas(int codedita) async {
  List<Area> areas = [];
  try {
    var url = Uri.http(IP, '/api/Area/codedita', {'codedita': codedita.toString()});
    var response = await http.get(url).timeout(const Duration(seconds: 30));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Decode JSON response
      var responseBody = jsonDecode(response.body) as List<dynamic>;
      print('Decoded response body: $responseBody');

      // Convert JSON list to list of Area objects
      areas = responseBody.map((data) {
        print('Mapping data: $data');
        return Area.fromJson(data as Map<String, dynamic>);
      }).toList();

      print("Areas fetched: ${areas.length}");

      // Save data to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Areas', jsonEncode(responseBody));
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return areas;
}
