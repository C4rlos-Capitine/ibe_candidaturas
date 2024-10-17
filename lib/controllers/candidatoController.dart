
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/model/Candidatura.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/local_storage/storageManagment.dart'; 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/http_response/http_response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';


Future<bool> login(String email, String senha) async {
  print(senha);
  try {
    var url = Uri.http(IP, '/api/Candidato/search', {
      'email': email,
      'password': senha,
    });

    var response = await http.get(url).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);

      // Ensure 'findTrue' is checked before accessing other fields
      if (responseBody['findTrue'] == true) {
        // Create a Candidato instance from the response
        Candidato candidato = Candidato.fromMap(responseBody);
        await StorageUtils.saveCandidato(candidato);
        StorageUtils.onLogin(email);
        //await StorageUtils.saveEmail(_email.text);
        return true;
      }
    }
    return false;
  } catch (e) {
    print('Error during HTTP request: $e');
    return false;
  }
}

Future<Candidato?> attemptLocalLogin(String email, String senha) async {
  Candidato? candidato = await StorageUtils.loadCandidato();
  if (candidato != null && candidato.email == email) {
    return candidato;
  }
  return null;
}

Future<Candidato> getData(String email, String senha) async {
  Candidato candidato_inExistente = Candidato(
    nome: "",
    apelido: "",
    codigo: 0,
    telefone: "",
    telemovel: "",
    email: "email",
    findTrue: true,
    idade: 0,
    identificacao: "",
    naturalidade: "",
    datadena: "", data_emissao: '', data_validade: '', genero: "", provincia: "", codprovi: 0, rua: "", ocupacao: "", edital: '', area: '', especialidade: '', estado: '', nomecomp: '', nivel: '', pontuacao: 0
  );

  try {
    var url = Uri.http(IP, '/api/Candidato/search', {
      'email': email,
      'password': senha,
    });

    var response = await http.get(url, headers: {'Content-Type': 'application/json'}).timeout(Duration(seconds: 10));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['findTrue'] == true) {
        Candidato candidato = Candidato(
          nome: responseBody["nome"],
          apelido: responseBody["apelido"],
          codigo: responseBody["codcandi"],
          telefone: responseBody["telefone"],
          telemovel: responseBody["telemovel"],
          email: responseBody["email"],
          findTrue: responseBody['findTrue'],
          idade: responseBody["idade"],
          identificacao: responseBody["identificacao"],
          naturalidade: responseBody["naturalidade"],
          datadena: responseBody["datadena"],
          data_emissao: responseBody['data_emissao'],
          data_validade: responseBody['data_validade'],
          genero: responseBody['genero'],
          provincia: responseBody['provincia'],
          codprovi: responseBody['codprovi'],
          rua: responseBody["rua"],
          ocupacao: responseBody["ocupacao"], 
          edital: responseBody["edital"],
          area: responseBody["area"],
          especialidade: responseBody["especialidade"], 
          estado: responseBody["estado"], 
          nomecomp: responseBody['nomecomp'],
          nivel: responseBody['nivel'], pontuacao: responseBody['pontuacao']
        );

        // Save to local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // Convert Candidato to JSON string
        String candidatoJson = jsonEncode(candidato.toJson());
        await prefs.setString('candidato', candidatoJson);

        return candidato;
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return candidato_inExistente;
}


Future<bool> registar(nome, apelido, email, senha, telemovel, telefone, id,
    tipo_doc, genero, dataNaci, dia, mes, ano, cod_provinc, naturalidade, rua, ocupacao, dataEmissao_doc, 
    dataValidade_doc, dia_emissao, mes_emissao, ano_emissao, dia_validade, mes_validade, ano_validade, codedita, codarea, especialidade) async {
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
      'ocupacao':ocupacao,
      'dia_emissao': dia_emissao,
      'mes_emissao':mes_emissao,
      'ano_emissao':ano_emissao,
      'dia_validade': dia_validade,
      'mes_validade':mes_validade,
      'ano_validade': ano_validade,
      'codedital': codedita,
      'codarea': codarea,
      'especialidade': especialidade,
      'nivel':'L'
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
        //ResquestResponse httpResponse = ResquestResponse(response.statusCode, responseBody['message'], success, body)
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

Future <ResquestResponse> registar2(nome, apelido, email, senha, telemovel, telefone, id,
    tipo_doc, genero, dataNaci, dia, mes, ano, cod_provinc, naturalidade, rua, ocupacao, dataEmissao_doc, 
    dataValidade_doc, dia_emissao, mes_emissao, ano_emissao, dia_validade, mes_validade, 
    ano_validade, codedita, codarea, especialidade, int nivel, media, nuit, ISorfao, bool pai, bool mae, bairro, posto, localidade) async{
  var level = "";
  var doc = "B";
  if(nivel==0){
    level = "E";
  }else if(nivel == 1){
    level = "ET";
  }else if(nivel == 2){
    level = "L";
  }else if(nivel == 3){
    level = "M";
  }else if(nivel==4){
    level = "D";
  }
  if(tipo_doc=="Passaport"){
    doc = "P";
  }

  int IsOrfaoPai = 0;
  int IsOrfaoMae = 0;
  if(ISorfao == "Sim"){

    if(pai==true){
      IsOrfaoPai = 1;
    }
    if(mae==true){
      IsOrfaoMae = 1;
    }else{
      ISorfao = "Não";
    }
  }
  print("level: $level");
  print("Doc: $doc");
  ResquestResponse httpRespponse = new ResquestResponse(0, "requesição não realizada", false);
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
      'ocupacao':ocupacao,
      'dia_emissao': dia_emissao,
      'mes_emissao':mes_emissao,
      'ano_emissao':ano_emissao,
      'dia_validade': dia_validade,
      'mes_validade':mes_validade,
      'ano_validade': ano_validade,
      'codedital': codedita,
      'codarea': codarea,
      'especialidade': especialidade,
      'nivel':level,
      'tipo_doc': doc,
      'nuit':int.parse(nuit),
      'media_obt':int.parse(media),
      'eorfao': ISorfao[0],
      'pai': IsOrfaoPai,
      'mae': IsOrfaoMae,
      'bairro': bairro,
      'posto' : posto,
      //'localidade':localidade
    });

    print(requestBody);
     SharedPreferences prefs = await SharedPreferences.getInstance();
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
        return new ResquestResponse(response.statusCode, responseBody['message'], true);
      }else{
        return new ResquestResponse(response.statusCode, responseBody['message'], false);
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      var responseBody2 = jsonDecode(response.body);
         return new ResquestResponse(response.statusCode, responseBody2['message'], false);
    }
  } catch (e) {
    // Exception occurred during HTTP request
    print('Error during HTTP request: $e');
  }
  

  return httpRespponse;
}

Future <bool> actualizar (nome, apelido, email, senha, telemovel, telefone, id,
    tipo_doc, genero, dataNaci, dia, mes, ano, cod_provinc, naturalidade, rua, ocupacao, int codcandi) async {
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
      'ocupacao':ocupacao,

    });

    print(requestBody);

    var url = Uri.http(IP, '/api/Candidato/codcandi=$codcandi');

    // Enviar a requisição POST com o corpo JSON
    var response = await http
        .put(url,
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


Future<void> downloadAndOpenFile(String email) async {
  try {
    // Get the directory to store the downloaded file
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/comprovativo.pdf';
    
    // Make the HTTP request to download the file
    final response = await http.get(Uri.parse("http://$IP/api/Report/report?email=$email"));
    
    // Check if the request was successful
    if (response.statusCode == 200) {
      final file = File(filePath);
      // Write the response body to the file
      await file.writeAsBytes(response.bodyBytes);
      print('File downloaded to $filePath');

      // Open the file
      final result = await OpenFilex.open(filePath);
      if (result.type != ResultType.done) {
        print('Failed to open file: ${result.message}');
      }
    } else {
      print('Failed to download file: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

