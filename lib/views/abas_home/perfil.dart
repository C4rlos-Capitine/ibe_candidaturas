import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';

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
          Card(
            color: Colors.white70,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Dados Pessoais",
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 44, 226),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
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
          Card(
            color: Colors.white70,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    "Contactos",
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 44, 226),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("N. telefone", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${candidato.telefone}", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("N. Celular", style: TextStyle(fontWeight: FontWeight.bold)),
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
          Card(
            color: Colors.white70,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    "Formação",
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 44, 226),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Inst. ensino", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("candidato.instituicaoEnsino", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("CURSO", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("candidato.curso", style: TextStyle(fontWeight: FontWeight.bold)),
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
                Navigator.pushNamed(context, "/editar");
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
