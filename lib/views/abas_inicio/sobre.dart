import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SobreNos extends StatefulWidget {
  const SobreNos({super.key});

  @override
  State<SobreNos> createState() => _SobreNosState();
}

class _SobreNosState extends State<SobreNos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: 30,),
          Container(
              alignment: Alignment.topCenter,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text("Quem somo nós", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("O IBE é uma instituição pública de âmbito nacional com autonomia administrativa, tutelado por Ministro que superintende a área do Enisno Superior. Criado por Decreto 30/2007 de 10 de Agosto e revisto pelo Decreto nº 24/2017 de 10 de Junho.", 
                      style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
                      
                    ],
                  ),
                ),
              ),
            ),
          Container(
          padding: EdgeInsets.all(5),
          child: Card( 
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [ 
                    Text("Nossos contactos", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.email, color: Colors.blue[900],),
                    Text("secretaria@ibe.gov.mz")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.phone, color: Colors.blue[900],),
                    Text("(+258) 21488826")
                  ],
                ),
              ],
            ),
            )
          ),
        ),
        Container(
            padding: EdgeInsets.all(1),
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.place, color: Colors.blue[900],),
                  Text("Av. Mártires da Machava nº 231, Maputo")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}