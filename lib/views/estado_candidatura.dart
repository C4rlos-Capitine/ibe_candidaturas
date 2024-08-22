import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';

class EstadoCandidatura extends StatefulWidget {
  final Candidato candidato;
  final int cod_edital;
  final int codecurso;
  final int codcandi;
  final String curso;
  final String edital;
  final String estado;
  final String resultado;
  final String data_submissao;
  const EstadoCandidatura({super.key, required this.candidato, required this.cod_edital, required this.codecurso, required this.codcandi, required this.curso, required this.edital, required this.estado, required this.resultado, required this.data_submissao});

  @override
  State<EstadoCandidatura> createState() => _EstadoCandidaturaState();
}

class _EstadoCandidaturaState extends State<EstadoCandidatura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          actions: [],
          title: Text("IBE - Portal do Candidato", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue[900],
        ),
      body: ListView(
        children: [
          Card(
            color: Colors.white70,
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text("Estado da Candidatura", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),),
            )
          ),
          Card(
            color: Colors.white70,
            child: Padding(
              padding: EdgeInsets.all(50),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Candidato: ", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(widget.candidato.nome +" "+widget.candidato.apelido, style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white70,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
              children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Edital", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${widget.edital}', style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Codigo do edital:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${widget.cod_edital}', style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Estado", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.estado, style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Data de Submissão", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.data_submissao, style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            )
          ),
          Card(
            color: Colors.white70,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
              
              children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Curso:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.curso, style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Resultado", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.resultado, style: TextStyle(fontWeight: FontWeight.bold))
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