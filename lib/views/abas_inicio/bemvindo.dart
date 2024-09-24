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
      backgroundColor: Colors.white,
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
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(70),
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
              margin: EdgeInsets.fromLTRB(30, 5, 30, 50),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("O IBE é uma instituição pública de âmbito nacional com autonomia administrativa, tutelado por Ministro que superintende a área do Enisno Superior.\n Criado por Decreto 30/2007 de 10 de Agosto e revisto pelo Decreto nº 24/2017 de 10 de Junho.",
                    style: TextStyle( fontSize: 13), textAlign: TextAlign.justify,),
                    
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