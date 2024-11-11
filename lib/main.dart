import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/local_storage/storageManagment.dart';
import 'package:ibe_candidaturas/views/abas_inicio/login.dart';
import 'package:ibe_candidaturas/views/home.dart';
import 'package:ibe_candidaturas/views/inicio.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necessário para inicializar corretamente

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "basic_channel_group",
        channelName: "Notificação",
        channelDescription: "channelDescription",
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic group",
      ),
    ],
  );

  bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  await initiateService();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      initialRoute: '/inicio',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => MyHomePage(title: "IBE,IP - Candidaturas"),
        '/inicio': (context) => Inicio(),
      },
    ),
  );
}

Future<void> initiateService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true, // Auto start when the device is rebooted
    ),
  );

  await service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // Send notifications and invoke API every 15 seconds
    Timer.periodic(const Duration(hours: 24), (timer) async {
      if (await service.isForegroundService()) {
        // Update foreground notification info
        service.setForegroundNotificationInfo(
          title: "IBE,IP - Notificações",
          content: "Update at ${DateTime.now()}",
        );

        // Invoke the API call
        await apiCall();
      }
    });
  }
}

Future<void> apiCall() async {
  var email = await StorageUtils.getLastEmail();
  var url = Uri.http(IP, '/api/Mensagens/$email');///PAREI AQUI, ADCIONE PARAMENTRO
 // var url = Uri.http(IP, '/api/Curso');
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody); 
      
      // Enviar notificação com o resultado da API
      await sendNotification(responseBody["msg"]);
      
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('API call error: $e');
  }
}

Future<void> sendNotification(dynamic responseBody) async {
  String title = "IBE,IP - Portal do candidato";
  String content = "Dados recebidos: ${responseBody.toString()}";

  await AwesomeNotifications().createNotification(
  content: NotificationContent(
    channelKey: 'basic_channel_group',
    title: title,
    body: content,
    id: 1,
    notificationLayout: NotificationLayout.Default, // Choose your layout
    bigPicture: 'assets/images/icon.png', // Replace with your image resource
    displayOnBackground: true,
    displayOnForeground: true,
    color: Colors.blue
  ),
);

}


