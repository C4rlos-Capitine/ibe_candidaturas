import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/model/Candidatura.dart';
import 'package:ibe_candidaturas/local_storage/storageManagment.dart'; 

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

  void _fetchCandidaturas() async {
  List<Candidatura> candidaturas = [];
  bool hasNetworkError = false;

  try {
    // Primeiro, tente buscar candidaturas da rede
    candidaturas = await getCandidaturas(widget.candidato.codigo);
    if (candidaturas.isNotEmpty) {
      // Se conseguir buscar dados da rede, salve-os localmente
      await StorageUtils.saveCandidaturas(widget.candidato.codigo, candidaturas);
      print('Dados obtidos e salvos localmente');
    }
  } catch (e) {
    print('Erro durante a requisição HTTP: $e');
    hasNetworkError = true;
  }

  // Se houve um erro de rede ou não há dados, tente carregar os dados do armazenamento local
  if (hasNetworkError || candidaturas.isEmpty) {
    candidaturas = (await StorageUtils.loadCandidaturas(widget.candidato.codigo));
    if (candidaturas.isEmpty) {
      // Se ainda não houver dados, informe ao usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível carregar as candidaturas.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      print('Dados carregados do armazenamento local');
    }
  }

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
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EstadoCandidatura(candidato: ca,)) 
                      );*/
                  },
                  ),
                );
              },
            ),
    );
  }
}