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
            
            child: Column(
                
                children: [
                  Text("Dados Pessoais"),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("NOME:"), Text("CARLOS MUTEMBA")]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("BI:"), Text("1111111111")]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("DATA DE NASCIMENTO:"), Text("dd/mm/yyyy")]),
                ]     
            ),
          ),
            SizedBox(height: 15),
          Card(
            child: Column(
              children: [
                Text("Contactos"),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("N. TELEFONE"), Text("88888888")],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("E-MAIL"), Text("carlos@gmail.com")],)
              ],
            ),
          ),
           SizedBox(height: 15),
          Card(
            child: Column(
              children: [
                Text("Formação"),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("INST. ENSINO"), Text("AAAAAAAAAAAA")],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("CURSO"), Text("ARQUITECTURA")],)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: ElevatedButton(onPressed: (){Navigator.pushNamed(context, "/editar");}, child: Text("Editar dados"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900], foregroundColor: Colors.white)),
              
          ),
        ],
      ),
    );
  }
}