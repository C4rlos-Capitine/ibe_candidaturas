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
                    Text("INSTITUTO DE BOLSAS DE ESTUDO", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("BEM VINDO AO PORTAL DO CANDIDATO", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 16)),
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