import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "/api/Candidatura"; // Replace with your API URL
var url = Uri.http('localhost:5284', '/api/Candidato');
  Future<void> syncCandidato(Map<String, dynamic> candidato) async {
    final response = await http.post(
      Uri.parse('$apiUrl/candidatos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(candidato),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to sync candidato');
    }
  }
}
