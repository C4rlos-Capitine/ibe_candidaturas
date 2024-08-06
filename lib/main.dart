import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/views/cadastrar.dart';
import 'package:ibe_candidaturas/views/login.dart';
import 'package:ibe_candidaturas/views/home.dart';
import 'package:ibe_candidaturas/views/principal.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';
import 'package:ibe_candidaturas/views/inicio.dart';

void main() {
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
