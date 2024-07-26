import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Card(
            
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                
                children: [
                  Text("Dados Pessoais", style: TextStyle(color: Color.fromARGB(255, 3, 44, 226), fontWeight: FontWeight.bold, fontSize: 16)),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("NOME:", style: TextStyle(fontWeight: FontWeight.bold)), Text("CARLOS MUTEMBA", style: TextStyle(fontWeight: FontWeight.bold))]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("BI:", style: TextStyle(fontWeight: FontWeight.bold)), Text("1111111111", style: TextStyle(fontWeight: FontWeight.bold))]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("DATA DE NASCIMENTO:", style: TextStyle(fontWeight: FontWeight.bold)), Text("dd/mm/yyyy", style: TextStyle(fontWeight: FontWeight.bold))]),
                ]     
            ),
            )
          ),
            SizedBox(height: 15),
          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text("Contactos", style: TextStyle(color: Color.fromARGB(255, 3, 44, 226), fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("N. TELEFONE", style: TextStyle(fontWeight: FontWeight.bold)), Text("88888888", style: TextStyle(fontWeight: FontWeight.bold))],),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("E-MAIL", style: TextStyle(fontWeight: FontWeight.bold)), Text("carlos@gmail.com", style: TextStyle(fontWeight: FontWeight.bold))],)
                ],
              ),
            )
          ),
           SizedBox(height: 15),
          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
              children: [
                Text("Formação", style: TextStyle(color: Color.fromARGB(255, 3, 44, 226), fontWeight: FontWeight.bold, fontSize: 16)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("INST. ENSINO", style: TextStyle(fontWeight: FontWeight.bold)), Text("AAAAAAAAAAAA", style: TextStyle(fontWeight: FontWeight.bold))],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("CURSO", style: TextStyle(fontWeight: FontWeight.bold)), Text("ARQUITECTURA", style: TextStyle(fontWeight: FontWeight.bold))],)
              ],
              ), 
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: ElevatedButton(onPressed: (){Navigator.pushNamed(context, "/editar");}, child: Text("Editar dados", style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900], foregroundColor: Colors.white)),
              
          ),
        ],
      ),
    );
  }
}