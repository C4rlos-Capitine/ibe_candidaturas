import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/config.dart';

Future<bool> recoverPassword(String email) async {
  bool resp = false;
  try {
    var url = Uri.http(IP, 'api/Mail');

    // Create the body as a JSON map
    var body = jsonEncode({
      'emailToId': email,
      'emailToName': email,
      'emailSubject': 'Recuperar senha',
      'password': ''
    });

    // Make the POST request with headers
    var response = await http
        .post(
          url,
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: body,
        )
        .timeout(const Duration(seconds: 45));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // Handle successful response
      print(responseBody);
      resp = responseBody;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } on TimeoutException catch (e) {
    print('Request timed out: $e');
  } catch (e) {
    print('Error during HTTP request: $e');
  }
  return resp;
}

Future<void> ConfirmEnrollment(String email, String senha, String nome) async{
  bool resp = false;
  try {
    var url = Uri.http(IP, 'api/Mail');

    // Create the body as a JSON map
    var body = jsonEncode({
      'emailToId': email,
      'emailToName': nome,
      'emailSubject': 'Confirmação da inscrição',
      'password': senha
    });

    // Make the POST request with headers
    var response = await http
        .post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: body,
    )
        .timeout(const Duration(seconds: 30));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // Handle successful response
      print(responseBody);
      resp = responseBody;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } on TimeoutException catch (e) {
    print('Request timed out: $e');
  } catch (e) {
    print('Error during HTTP request: $e');
  }

}
