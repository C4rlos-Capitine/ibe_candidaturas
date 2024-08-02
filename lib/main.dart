import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/views/cadastrar.dart';
import 'package:ibe_candidaturas/views/login.dart';
import 'package:ibe_candidaturas/views/home.dart';
import 'package:ibe_candidaturas/views/principal.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';
import 'package:ibe_candidaturas/views/nova_candidatura.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/cadastro': (context) => Cadastro(),
        '/login': (context) => Login(),
        '/home': (context) => MyHomePage(title: "IBE - Candidaturas"),
        '/principal': (context) => Principal(),
        //'/nova_candidatura': (context) => NovaCandidatura(codedita: null),
        '/estado': (context) => EstadoCandidatura()
      },
    ),
  );
}
