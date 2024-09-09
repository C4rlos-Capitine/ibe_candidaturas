import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/model/Edital.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';  // For TimeoutException

/*
Future<List<Edital>> getEditais() async {
  List<Edital> editais = [];
  try {
    // Use the correct IP address for localhost
    var url = Uri.http(IP, '/api/Edital');

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
*/


Future<List<Edital>> getEditais() async {
  List<Edital> editais = [];
  try {
    var url = Uri.http(IP, '/api/Edital');

    var response = await http.get(url).timeout(const Duration(seconds: 30));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);

      editais = responseBody.map((data) => Edital.fromJson(data)).toList();
      
      print("Editais fetched: ${editais.length}");

      // Save data to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('editais', jsonEncode(responseBody));
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } on TimeoutException catch (e) {
    print('Request timed out: $e');
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return editais;
}



Future<List<Edital>> loadEditaisFromLocal() async {
  List<Edital> editais = [];
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('editais');

    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      editais = jsonData.map((data) => Edital.fromJson(data)).toList();
    }
  } catch (e) {
    print('Error loading data from local storage: $e');
  }
  return editais;
}

Future<List<Edital>> fetchEditais() async {
  List<Edital> editais = await getEditais(); // Fetch from the server

  if (editais.isEmpty) {
    // If no data was fetched from the server, try loading from local storage
    editais = await loadEditaisFromLocal();
  }

  return editais;
}

