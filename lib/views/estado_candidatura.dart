import 'package:flutter/material.dart';

class EstadoCandidatura extends StatefulWidget {
  const EstadoCandidatura({super.key});

  @override
  State<EstadoCandidatura> createState() => _EstadoCandidaturaState();
}

class _EstadoCandidaturaState extends State<EstadoCandidatura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [],
          title: Text("IBE - Portal do Candidato", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue[900],
        ),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(30),
              
              child: Text("ESTADO DA CANDIDATURA", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),),
            )
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(50),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Candidato: ", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Carlos Mutemba", style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
              children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Edital", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("AAAAAA/2024", style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Estado", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Em avaliação", style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            )
          ),
          Card(
            
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
              
              children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Curso:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Enge. Tecnologias", style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Vagas", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("30", style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );;
  }
}