import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/views/cadastrar.dart';
import 'package:ibe_candidaturas/views/login.dart';
import 'package:ibe_candidaturas/views/home.dart';
import 'package:ibe_candidaturas/views/principal.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';
import 'package:ibe_candidaturas/views/inicio.dart';

//import 'package:workmanager/workmanager.dart';

void main() {
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
        '/home': (context) => MyHomePage(title: "IBE - Candidaturas"),
        '/principal': (context) => Principal(),
        '/inicio': (context) => Inicio()
      },
    ),
  );
}
