import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/controllers/cursoController.dart';
import 'package:ibe_candidaturas/model/Curso.dart';

class NovaCandidatura extends StatefulWidget {
  const NovaCandidatura({super.key, required this.codedita, required this.ano, required this.numero, required this.nome});
  final int codedita;
  final int ano;
  final int numero;
  final String nome;
  
  @override
  State<NovaCandidatura> createState() => _NovaCandidaturaState();
}

class _NovaCandidaturaState extends State<NovaCandidatura> {
  List<Curso>? _cursos;
  String? nome_curso; // Ensure nome_curso is nullable
  List<String>? lista_cursos;

  @override
  void initState() {
    super.initState();
    _fetchCursos();
  }

  Future<void> _fetchCursos() async {
    try {
      List<Curso>? cursos = await getCursos();
      setState(() {
        _cursos = cursos;
        lista_cursos = cursos?.map((curso) => curso.nome).toList(); // Update lista_cursos here
        print(lista_cursos);
      });
    } catch (e) {
      // Handle errors here
      print('Error loading editais: $e');
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
                      ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                          content: Text('Edital Baixado para o celular'),
                          backgroundColor: Color.fromARGB(255, 8, 224, 134),
                        ),
                      );
                    }, 
                    icon: Icon(Icons.file_download)
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
              items: (lista_cursos ?? []).map((label) => DropdownMenuItem<String>(
                child: Text(label),
                value: label,
              )).toList(),
              onChanged: (value) {
                setState(() {
                  nome_curso = value;
                  print(nome_curso);
                });
              },
            ),
          ),

           Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async{
                //bool resp = await registar(_nomeController.text, _apelidoController.text,_emailController.text,_passwordController.text,_telemovelController.text, _telefoneController.text,_docController.text,1, _selectedGender, _dataController.text, dia, mes, ano);
              /* if(resp){
                print(resp.toString());
                  ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(
                      content: Text('Registado com sucesso'),
                      backgroundColor: Color.fromARGB(255, 8, 224, 134),
                    ),
                  );
                  //print response from server
                }else{
                  print("Erro de conexao.");
                  ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(
                    content: Text('Erro ao enviar os dados'),
                    backgroundColor: Color.fromARGB(255, 235, 77, 3),
                  ),
                 );
                }*/
              },
              child: Text(
                "Enviar Candidatura",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
