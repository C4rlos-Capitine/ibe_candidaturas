import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/controllers/cursoController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/model/Curso.dart';

class NovaCandidatura extends StatefulWidget {
  const NovaCandidatura({super.key, required this.codedita, required this.ano, required this.numero, required this.nome, required this.candidato});
  final int codedita;
  final int ano;
  final int numero;
  final String nome;
  final Candidato candidato;
  
  @override
  State<NovaCandidatura> createState() => _NovaCandidaturaState();
}

class _NovaCandidaturaState extends State<NovaCandidatura> {
  List<Curso>? _cursos;
  String? nome_curso;
  int? codprovinc;
  List<DropdownMenuItem<String>>? _dropdownMenuItems;

  @override
  void initState() {
    super.initState();
    _fetchCursos();
    print(widget.candidato.apelido);
  }

  Future<void> _fetchCursos() async {
    try {
      List<Curso>? cursos = await getCursos();
      setState(() {
        _cursos = cursos;
        _dropdownMenuItems = cursos?.map((curso) => DropdownMenuItem<String>(
          child: Text(curso.nome),

          value: curso.codcurso.toString(),
        )).toList();
        if (_dropdownMenuItems != null && _dropdownMenuItems!.isNotEmpty) {
          nome_curso = _dropdownMenuItems!.first.value; // Set a default value if there are courses
        }
      });
    } catch (e) {
      print('Error loading cursos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "IBE - Portal do Candidatos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 34, 88, 236),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Novas Bolsas'),
                content: const Text('Nenhuma bolsa lançada recentemente'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.blue[900]),
      ),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text("Nova Candidatura", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold)),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Edital: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${widget.nome}', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Baixar Edital: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Edital Baixado para o celular'),
                          backgroundColor: Color.fromARGB(255, 8, 224, 134),
                        ),
                      );
                    }, 
                    icon: Icon(Icons.file_download),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Vagas: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${widget.numero}', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.task, color: Colors.blue[900]),
                labelText: "Curso",
              ),
              value: nome_curso,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  try{
                    nome_curso = value;
                    codprovinc = _cursos?.firstWhere((curso) => curso.nome == value).codcurso;
                    print('Nome do Curso: $nome_curso, Código: $codprovinc');
                  }catch(e){
                    print(e);
                  }
                  
                });
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                // Your button action here
              },
              child: Text(
                "Enviar Candidatura",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
