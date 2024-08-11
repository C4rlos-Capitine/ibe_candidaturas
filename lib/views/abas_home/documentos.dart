import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Documentos extends StatefulWidget {
  const Documentos({super.key, required this.candidato});
  final Candidato candidato;

  @override
  State<Documentos> createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  String? _selectedType;
  late File selectedfilePath;
  String progress = "";
  String fileName = "";
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    print(widget.candidato);
    selectedfilePath = File('');
  }

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null) {
      setState(() {
        selectedfilePath = File(result.files.single.path!);
        fileName = basename(selectedfilePath.path);
        print("Selected file: $fileName");
      });
    }
  }

  void uploadFile(int codigo) async {
    if (selectedfilePath.path.isEmpty) {
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Nenhum ficheiro selecionado.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print("Uploading file: $fileName");
    print("File path: ${selectedfilePath.path}");

    // Adicionando o id como query string na URL
    String uploadurl = 'http://$IP/api/Doc/upload?id=$codigo';

    var request = http.MultipartRequest('POST', Uri.parse(uploadurl));

    // Adicionando o arquivo ao pedido
    request.files.add(await http.MultipartFile.fromPath(
      'file', // Certifique-se de que o nome 'file' é o esperado pela API
      selectedfilePath.path,
      filename: fileName,
    ));

    // Verificando o conteúdo da solicitação antes de enviá-la
    print("Request URL: $uploadurl");
    print(
        "Request files: ${request.files.map((file) => file.filename).join(', ')}");

    try {
      var response = await request.send();

      // Obtendo a resposta completa para depuração
      var responseData = await http.Response.fromStream(response);
      print("Response status: ${response.statusCode}");
      print("Response body: ${responseData.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Upload successful!");
        ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(
            content: Text('Documento enviado com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print("Erro de conexão: ${response.statusCode}");
        ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar: ${response.statusCode}'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      print("Erro: $e");
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar o documento'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final candidato = widget.candidato;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Text("Documentos",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 3, 55, 226),
                      fontSize: 16)),
              Text("Selecione o tipo de documento",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("$fileName",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 3, 55, 226),
                      fontSize: 16)),
              Text("$progress", style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(40),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusColor: Colors.blue[900],
                    hintText: "Selecione o tipo",
                    labelText: "Tipo de documento",
                  ),
                  value: _selectedType,
                  items: ["Certificado", "BI", "NUIT"]
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(EvaIcons.fileAdd,
                        color: Color.fromARGB(255, 34, 37, 199)),
                    onPressed: selectFile,
                    label: Text("Selecionar ficheiro"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton.icon(
                    icon: const Icon(EvaIcons.upload,
                        color: Color.fromARGB(255, 34, 37, 199)),
                    onPressed: () => uploadFile(widget.candidato.codigo),
                    label: Text("Enviar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
