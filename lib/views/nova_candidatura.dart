import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/controllers/areaController.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/controllers/cursoController.dart';
import 'package:ibe_candidaturas/model/Area.dart';
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
  int? cod_curso;
  List<DropdownMenuItem<String>>? _dropdownMenuItems;
  List<Area>? _areas;
  TextEditingController _especialidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAreas();
    print(widget.candidato.apelido);
  }

  Future<void> _getAreas() async{
    try{
      List <Area>? areas = await getAreas(1);
      setState(() {
        _areas = areas;
        
        _dropdownMenuItems = areas?.map((area) => DropdownMenuItem<String>(
          child: Text(area.nome),

          value: area.codarea.toString()
        )).toList();
        if (_dropdownMenuItems != null && _dropdownMenuItems!.isNotEmpty) {
          nome_curso = _dropdownMenuItems!.first.value; // Set a default value if there are courses
        }
      });
    }catch(e){

    }
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "IBE - Portal do Candidato",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 34, 88, 236),
        actions: <Widget>[
         
        ],
        iconTheme: IconThemeData(color: Colors.blue[900]),
      ),
      body: ListView(
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
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
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 248, 245, 245),
              borderRadius: BorderRadius.circular(10),
              ),
            child: DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.subject, color: Colors.blue[900]),
                  labelText: "Selecione a área",
                  hintStyle:TextStyle(color: Colors.blue[900]),
                  labelStyle: TextStyle(color: Colors.blue[900]),
                ),
              value: nome_curso,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  try{
                    print(value);
                    nome_curso = value;
                    print(nome_curso);
                    //cod_curso = value;//_cursos?.firstWhere((curso) => curso.nome == value).codcurso;
                    //print(_cursos?.firstWhere((curso) => curso.nome == value).codcurso);
                  
                  }catch(e){
                    print(e);
                  }
                  
                });
              },
            ),
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _especialidadeController,
                keyboardType: TextInputType.text,
               // maxLength: 25,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Especialidade:", style: TextStyle(color: Colors.blue[900]),),
                  //icon: Icon(, color: Colors.blue[900]),
                  hintText: "Informe a especialidade.",
                ),
              ),
            ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                 ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Não pode se candidatar a duas bolsas em simultaneo'),
                        backgroundColor: Color.fromARGB(255, 235, 77, 3),
                      ),
                    );
                // Your button action here
                /*bool saved = await saveCandidatura(widget.candidato.codigo, widget.codedita, nome_curso);
                if(saved==true){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Candidatura submetida com sucesso'),
                        backgroundColor: Color.fromARGB(255, 5, 228, 42),
                      ),
                    );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Falha na submissão'),
                        backgroundColor: Color.fromARGB(255, 235, 77, 3),
                      ),
                    );
                }*/
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
