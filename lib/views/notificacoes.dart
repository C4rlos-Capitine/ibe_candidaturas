import 'package:flutter/material.dart';

class Notificacoes extends StatefulWidget {
  const Notificacoes({super.key});

  @override
  State<Notificacoes> createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          Text("Notificaçoes",  style: TextStyle(
            color: Color.fromARGB(255, 3, 44, 226),
            fontWeight: FontWeight.bold,
            fontSize: 16)),

          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Card(
              child: Text("mensagem:..............",),
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Card(
              child: Text("mensagem:.............."),
            ),
          ),
        ],
      ),
    );
  }
}