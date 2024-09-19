import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:ibe_candidaturas/views/cadastrar.dart';
import 'package:ibe_candidaturas/views/login.dart';
import 'package:ibe_candidaturas/views/home.dart';
//import 'package:ibe_candidaturas/views/principal.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';
import 'package:ibe_candidaturas/views/inicio.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//import 'package:workmanager/workmanager.dart';

Future<void> main() async {

    //WidgetsFlutterBinding.ensureInitialized();
  //await initiateService();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),  
      initialRoute: '/inicio',
      routes: {
       // '/cadastro': (context) => Cadastro(),
        '/login': (context) => Login(),
        '/home': (context) => MyHomePage(title: "IBE,IP - Candidaturas"),
       // '/principal': (context) => Principal(),
        '/inicio': (context) => Inicio()
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

    // Send notifications and invoke API every 5 seconds
    Timer.periodic(const Duration(seconds: 15), (timer) async {
      if (await service.isForegroundService()) {
        // Update foreground notification info
        service.setForegroundNotificationInfo(
          title: "My App Service",
          content: "Update at ${DateTime.now()}",
        );

        // Invoke the API call
        await apiCall();
      }
    });
  }
}

Future<void> apiCall() async {
  var url = Uri.http('5.189.138.20:8999', '/api/Curso');

  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('API call error: $e');
  }
}

