import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/model/Mensagens.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissReceivedMethod(
      ReceivedNotification receivedNotification) async {}

  static Future<List<Mensagens>> getMesg(String email) async {
    List<Mensagens> mensagens = [];
    print(email);
    try {
      var url = Uri.http(IP, '/api/Msg/$email');

      var response = await http.get(url).timeout(const Duration(seconds: 30));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Decode the response body as a List
        List<dynamic> responseBody = jsonDecode(response.body);

        // Map the response to a List of Mensagens
        mensagens = responseBody.map((data) => Mensagens.fromMap(data)).toList();
        print(mensagens);
        print("Mensagens fetched: ${mensagens.length}");
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Request timed out: $e');
    } catch (e) {
      print('Error during HTTP request: $e');
    }
    return mensagens; // Return the list of mensagens
  }

  static Future<void> marcarLida(String email) async{
    try {
      var url = Uri.http(IP, '/api/MsgUpdate/$email');

      var response = await http.post(url).timeout(const Duration(seconds: 30));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Decode the response body as a List

      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Request timed out: $e');
    } catch (e) {
      print('Error during HTTP request: $e');
    }
  }
  
}
