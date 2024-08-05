import 'package:flutter/material.dart';

class Bemvindo extends StatefulWidget {
  const Bemvindo({super.key});

  @override
  State<Bemvindo> createState() => _BemvindoState();
}

class _BemvindoState extends State<Bemvindo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(70.0),
            
            child: Image.asset(
              'assets/images/ibe_moz.png',
              fit: BoxFit.scaleDown, // Adjust the fit property as needed
            ),
          ),

          Container(
            alignment: Alignment.topCenter,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  children: [
                    Text("BEM VINDO AO PORTAL DO CANDIDATO", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),

          Container(
            alignment: Alignment.topCenter,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  children: [
                    Text("O IBE é uma instituição pública de âmbito nacional com autonomia administrativa, tutelado por Ministro que superintende a área do Enisno Superior. Criado por Decreto 30/2007 de 10 de Agosto e revisto pelo Decreto nº 24/2017 de 10 de Junho.", style: TextStyle( fontSize: 12)),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}