import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> login(senha, email) async {
  try {
    var url = Uri.http('localhost:5284', '/api/Candidato/search', {
      'email': email,
      'telefone': senha,
      // Add more parameters as needed
    });

    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      final data = jsonDecode(response.body);
      print(data);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Exception occurred during HTTP request
    print('Error during HTTP request: $e');
  }
}
