import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/views/editar_dados.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key, required this.candidato});
  final Candidato candidato;

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    // Use widget.candidato directly instead of _candidato
    final candidato = widget.candidato;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: 10,),
          Container(
            //margin: EdgeInsets.symmetric(horizontal: 0,),
            padding: EdgeInsets.symmetric(vertical: 5),
            color:Color.fromARGB(255, 34, 88, 236),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Iconsax.personalcard, color: Colors.white,),
                  SizedBox(width: 10,),
                  Text(
                  "Dados Pessoais",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                ],
              )
          ),
          Container(
            //color: Colors.white70,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nome:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(candidato.nome, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Apelido:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(candidato.apelido, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("BI:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${candidato.identificacao}", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Idade:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${candidato.idade}", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Natural de:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${candidato.naturalidade!}", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
         Container(
            //margin: EdgeInsets.symmetric(horizontal: 0,),
            padding: EdgeInsets.symmetric(vertical: 5),
            color:Color.fromARGB(255, 34, 88, 236),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.contact_page, color: Colors.white,),
                  SizedBox(width: 10,),
                  Text(
                  "Cotactos",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                ],
              )
          ),
          
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Celular", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${candidato.telefone}", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Celular alternativo", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${candidato.telemovel}", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("E-mail", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(candidato.email, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            //margin: EdgeInsets.symmetric(horizontal: 0,),
            padding: EdgeInsets.symmetric(vertical: 5),
            color:Color.fromARGB(255, 34, 88, 236),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.school, color: Colors.white,),
                  SizedBox(width: 10,),
                  Text(
                  "Formação Académica",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                ],
              )
          ),
          
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nível", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Inst. de Ensino", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EditarDados(candidato: candidato)));
              },
              child: Text("Editar dados", style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
