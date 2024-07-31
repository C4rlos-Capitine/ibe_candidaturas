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
      body: ListView(
        children: [
          Card(
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
                      Text("NOME:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(candidato.nome, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("BI:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("candidato.bi", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("DATA DE NASCIMENTO:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Card(
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
                      Text("N. TELEFONE", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${candidato.telefone}", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("E-MAIL", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(candidato.email, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Card(
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
                      Text("INST. ENSINO", style: TextStyle(fontWeight: FontWeight.bold)),
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
