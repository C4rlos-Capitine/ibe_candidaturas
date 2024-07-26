import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';

class Candidaturas extends StatefulWidget {
  const Candidaturas({super.key});

  @override
  State<Candidaturas> createState() => _CandidaturasState();
}

class _CandidaturasState extends State<Candidaturas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2024 (toque para ver mais)"),
                onTap: () {
                  Navigator.pushNamed(context, '/estado');
                },
              ),
              
            ),
             Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2023 (toque para ver mais)"),
                onTap: () {
                  Navigator.pushNamed(context, '/estado');
                },
              ),
            ),
        ],
      ),
    );
  }
}