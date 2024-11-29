import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/http_response/http_response.dart';

Future <bool> SendAuthRequest(String email) async{
  bool resp = false;
  try {
    var url = Uri.http(IP, 'api/Mail');

    // Create the body as a JSON map
    var body = jsonEncode({
      'emailToId': email,
      'emailToName': email,
      'emailSubject': 'Recuperar senha',
      'password': '',
      'auth': 1,
      'name': email
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
      print("res: "+responseBody);
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
Future <ResquestResponse> SecoundAtuthentication(String email, String codigo) async{

  ResquestResponse httpRespponse = new ResquestResponse(0, "requesição não realizada", false);
    try {
      var url = Uri.http(IP, '/api/Auth/authenticate', {
        'email': email,
        'codigo': codigo

      });
      var response = await http
          .get(
            url,
            headers: {
              'Content-Type': 'application/json', // Set the content type to JSON
            },
          )
          .timeout(const Duration(seconds: 45));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
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
    } on TimeoutException catch (e) {
      print('Request timed out: $e');
    } catch (e) {
      print('Error during HTTP request: $e');
    }
    return httpRespponse;
}
/*
Future <bool> SecoundAtuthentication(String email, String codigo) async{
  bool resp = false;
  try {
    var url = Uri.http(IP, '/api/Auth/authenticate', {
      'email': email,
      'codigo': codigo

    });
    var response = await http
        .get(
          url,
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
        )
        .timeout(const Duration(seconds: 45));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      resp = responseBody["success"];
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

*/
Future <bool> SetLoggedIn(String email) async{
  bool resp = false;
  try {
    var url = Uri.http(IP, '/api/Auth/setAuthenticated', {
      'email': email,
    });
    var response = await http
        .post(
          url,
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
        )
        .timeout(const Duration(seconds: 45));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      resp = responseBody["success"];
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