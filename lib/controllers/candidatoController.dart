import 'dart:convert';
import 'package:ibe_candidaturas/config.dart';
import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/model/Candidatura.dart';

Future<bool> login(email, senha) async {
  bool resp = false;
  try {
    var url = Uri.http(IP, '/api/Candidato/search', {
      'email': email,
      'password': senha,
      // Add more parameters as needed
    });

    var response = await http.get(url).timeout(Duration(seconds: 10));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      final data = jsonDecode(response.body);
      print(data);
      if (responseBody['findTrue'] == true) {
        print("FOUND");
        resp = true;
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Exception occurred during HTTP request
    print('Error during HTTP request: $e');
  }
  return resp;
}

Future<Candidato> getData(String email, String senha) async {
  Candidato candidato_inExistente = new Candidato(
      nome: "",
      apelido: "",
      codigo: 0,
      telefone: "",
      telemovel: "",
      email: "email",
      isEmpty: true,
      idade: 0,
      identificacao: 0,
      naturalidade: ""
      );
  try {
    // Define the URL with query parameters
    var url = Uri.http(IP, '/api/Candidato/search', {
      'email': email,
      'password': senha,
    });

    // Make the HTTP GET request
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 10));

    // Print status and body for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Check if the response status is 200 (OK)
    if (response.statusCode == 200) {
      // Decode the response body to a map
      var responseBody = jsonDecode(response.body);
      print(responseBody);

      // Check if the response contains the FindTrue field
      if (responseBody['findTrue'] == true) {
        print("FOUND-2");
        return new Candidato(
            nome: responseBody["nome"],
            apelido: responseBody["apelido"],
            codigo: responseBody["codcandi"],
            telefone: responseBody["telefone"],
            telemovel: responseBody["telemovel"],
            email: responseBody["email"],
            isEmpty: false,
            idade: responseBody["idade"],
            identificacao: responseBody["num_ident"],
            naturalidade: responseBody["naturalidade"]
            );
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      return candidato_inExistente;
    }
  } catch (e) {
    // Exception occurred during HTTP request
    print('Error during HTTP request: $e');
    return candidato_inExistente;
  }
  return candidato_inExistente;
}

Future<bool> registar(nome, apelido, email, senha, telemovel, telefone, id,
    tipo_doc, genero, dataNaci, dia, mes, ano, cod_provinc, naturalidade, rua, ocupacao) async {
  bool resp = false;
  try {
    var gender = "M";
    if (genero != "Masculino") gender = "F";
    var idade = DateTime.now().year - ano;
    // Criar o corpo da requisição em formato JSON
    var requestBody = jsonEncode({
      'codcandi': 23, // Ajustar se necessário
      'nome': nome,
      'apelido': apelido,
      'nomecomp': '$nome $apelido',
      'telefone': telefone,
      'telemovel': telemovel,
      'email': email,
      'password': senha,
      'genero': gender,
      'num_ident': id,
      'dataNasc': dataNaci,
      'dia': dia,
      'mes': mes,
      'ano': ano,
      'idade': idade,
      'codprovi': cod_provinc,
      'naturalidade':naturalidade,
      "rua":rua,
      'ocupacao':ocupacao
    });

    print(requestBody);

    var url = Uri.http(IP, '/api/Candidato');

    // Enviar a requisição POST com o corpo JSON
    var response = await http
        .post(url,
            headers: {'Content-Type': 'application/json'}, body: requestBody)
        .timeout(Duration(seconds: 10));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      if (responseBody['success'] == true) {
        resp = true;
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Exception occurred during HTTP request
    print('Error during HTTP request: $e');
  }
  return resp;
}

Future<List<Candidatura>> getCandidaturas(int codcandi) async {
  List<Candidatura> candidaturas = [];
  try {
    var url = Uri.http(IP, '/api/Candidatura/$codcandi');

    var response = await http.get(url).timeout(Duration(seconds: 10));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Decode response as List of dynamic
      List<dynamic> responseBody = jsonDecode(response.body);

      // Map each item to Edital instance
      candidaturas =
          responseBody.map((data) => Candidatura.fromJson(data)).toList();

      print("Candidaturas fetched: ${candidaturas.length}");
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return candidaturas;
}

Future<bool> saveCandidatura(codcandi, cod_edital, cod_curso) async {
  var requestBody = jsonEncode({
    'codcandi': codcandi,
    'cod_edital': cod_edital,
    'codecurso': cod_curso,
    'dia_submissao': DateTime.now().day,
    'mes_submissao': DateTime.now().month,
    'ano_submissao': DateTime.now().year,
  });
  print(requestBody);
  bool resp = false;
  try {
    var url = Uri.http(IP, '/api/Candidatura');

    // Enviar a requisição POST com o corpo JSON
    var response = await http
        .post(url,
            headers: {'Content-Type': 'application/json'}, body: requestBody)
        .timeout(Duration(seconds: 10));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      if (responseBody['success'] == true) {
        resp = true;
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Exception occurred during HTTP request
    print('Error during HTTP request: $e');
  }
  return resp;
}
