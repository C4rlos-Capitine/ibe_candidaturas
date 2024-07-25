import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IBE - Porta do candidato"),
        backgroundColor: Colors.blue,

      ),

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
            //height: 30,
            padding: EdgeInsets.all(15),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                Card(
                   elevation: 4.0,
                   child: Column(
                    
                    children: [
                      Center(child: Icon(Icons.person, color: Color.fromARGB(255, 13, 71, 161))),
                      Text("Perfil", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 13, 71, 161)))
                    ],
                  )
                ),
                SizedBox(width: 15),
                Card(
                   elevation: 4.0,
                   child: Column(
                    children: [
                      Center(child: Icon(Icons.list, color: Color.fromARGB(255, 13, 71, 161))),
                      Text("Bolsas")
                    ],
                  )
                ),
              ],
            ),
          ),

          Container(
           // height: 30,
            padding: EdgeInsets.all(5),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      Center(child: Icon(Icons.list, color: Color.fromARGB(255, 13, 71, 161))),
                      Text("Candidaturas")
                    ],
                  )
                ),
                Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      Center(child: Icon(Icons.file_copy, color: Color.fromARGB(255, 13, 71, 161))),
                      Text("Documentos")
                    ],
                  )
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}