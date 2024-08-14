import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/model/Candidatura.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';

class Candidaturas extends StatefulWidget {
  final Candidato candidato;
  const Candidaturas({super.key, required this.candidato});

  @override
  State<Candidaturas> createState() => _CandidaturasState();
}

class _CandidaturasState extends State<Candidaturas> {
  List <Candidatura>? _candidaturas;
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.candidato.codigo);
    _fetchCandidaturas();
  }

  void _fetchCandidaturas() async{
      List<Candidatura> candidaturas = await getCandidaturas(widget.candidato.codigo);
      //print(candidaturas.first.edital);
      setState(() {
        _candidaturas = candidaturas;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Minhas bolsas", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 55, 226),fontSize: 16)),
      ),
      body:  _candidaturas == null 
      ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _candidaturas!.length,
              itemBuilder: (context, index) {
                final _candidatura = _candidaturas![index];
                return Card(
                  child: ListTile(
                  title: Text(_candidatura.edital),
                  subtitle: Text('Curso: ${_candidatura.curso}, Número: ${_candidatura.cod_edital}'),
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EstadoCandidatura(candidato: widget.candidato, cod_edital: _candidatura.cod_edital, codecurso: _candidatura.codecurso, codcandi: _candidatura.codcandi, curso: _candidatura.curso, edital: _candidatura.edital, estado: _candidatura.estado, resultado: _candidatura.resultado, data_submissao: _candidatura.data_submissao)) 
                      );
                  },
                  ),
                );
              },
            ),
    );
  }
}