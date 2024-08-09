import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/model/Curso.dart';


Future <List<Curso>>? getCursos() async{
  List <Curso> cursos = [];
  try{
     var url = Uri.http('192.168.10.162:5284', '/api/Curso');

      var response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Decode response as List of dynamic
        List<dynamic> responseBody = jsonDecode(response.body);

        // Map each item to Edital instance
        cursos = responseBody.map((data) => Curso.fromJson(data)).toList();

        print("Editais fetched: ${cursos.length}");
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during HTTP request: $e');
    }
  

  return cursos;
}