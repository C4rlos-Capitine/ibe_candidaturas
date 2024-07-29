import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> login(email, senha) async {
  try {
    var url = Uri.http('localhost:5284', '/api/Candidato/search', {
      'email': email,
      'password': senha,
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

Future<void> registar(nome, apelido, email, senha, telemovel, telefone, id, tipo_doc, genero)async {

  try {
    var gender = "M";
    if(genero != "Masculino")
      gender = "F";

    print( {'CODCANDI': 17,
      'NOME':nome,
      'APELIDO':apelido,
      'NOMECOMP': nome + " " + apelido,
      'TELEFONE': telefone,
      'TELEMOVE':telemovel,
      'EMAIL': email,
      'PASSWORD': senha,
      'GENERO': gender});

    var url = Uri.http('localhost:5284', '/api/Candidato', {
      'CODCANDI': 17,
      'NOME':nome,
      'APELIDO':apelido,
      'NOMECOMP': nome + " " + apelido,
      'TELEFONE': telefone,
      'TELEMOVE':telemovel,
      'EMAIL': email,
      'PASSWORD': senha,
      'GENERO': gender
      // Add more parameters as needed
    });

    var response = await http.post(url);

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
