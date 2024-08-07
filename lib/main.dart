import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/sqlite_connection/CRUD_Candidatos.dart';
import 'package:ibe_candidaturas/sqlite_connection/CRUD_Candidatos.dart';
import 'package:ibe_candidaturas/views/cadastrar.dart';
import 'package:ibe_candidaturas/views/login.dart';
import 'package:ibe_candidaturas/views/home.dart';
import 'package:ibe_candidaturas/views/principal.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';
import 'package:ibe_candidaturas/views/inicio.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

//import 'package:workmanager/workmanager.dart';

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    'syncTask',
    'syncCandidatos',
    frequency: Duration(minutes: 15), // Adjust the frequency as needed
  );*/
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor: Colors.blue[900],
      ),
      initialRoute: '/inicio',
      routes: {
        '/cadastro': (context) => Cadastro(),
        '/login': (context) => Login(),
        '/home': (context) => MyHomePage(title: "IBE - Candidaturas"),
        '/principal': (context) => Principal(),
        //'/nova_candidatura': (context) => NovaCandidatura(codedita: null),
        //'/estado': (context) => EstadoCandidatura(),
        '/inicio': (context) => Inicio()
      },
    ),
  );

}
