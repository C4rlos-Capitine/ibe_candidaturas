import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/views/editar_dados.dart';
import 'package:iconsax/iconsax.dart';


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
                      Text("Nome:"),
                      Text(candidato.nome),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Apelido:"),
                      Text(candidato.apelido),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("BI:"),
                      Text("${candidato.identificacao}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Idade:"),
                      Text("${candidato.idade}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Natural de:"),
                      Text("${candidato.naturalidade!}"),
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
                  "Contactos",
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
                      Text("Celular"),
                      Text("${candidato.telefone}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Celular alternativo"),
                      Text("${candidato.telemovel}"),
                    ],
                  ),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("E-mail"),
                      Text(candidato.email),
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
                      Text("Nível"),
                      Text("${candidato.nivel}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Inst. de Ensino"),
                      Text("",),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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

          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: ElevatedButton(
              onPressed: () {
                downloadAndOpenFile(candidato.email);
              },
              child: Text("Baixa comprovativo", style: TextStyle(fontWeight: FontWeight.bold)),
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
