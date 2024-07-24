import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/views/cadastrar.dart';
import 'package:ibe_candidaturas/views/login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/cadastro': (context) => Cadastro(),
      '/login': (context) => Login(),
    },
  ));
}
