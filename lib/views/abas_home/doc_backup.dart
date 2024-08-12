
/*
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';

class Documentos extends StatefulWidget {
  const Documentos({super.key, required this.candidato});
  final Candidato candidato;

  @override
  State<Documentos> createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  String? _selectedType;
  late File selectedfilePath;
  String progress = "0%";
  String fileName = "";
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
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

  void uploadFile(codigo) async {
    String cod = codigo.toString();
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

    String uploadurl = 'http://$IP/api/Doc/upload?id=$cod';

    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          selectedfilePath.path,
          filename: fileName,
        ),
      });

      await dio.post(
        uploadurl,
        data: formData,
        onSendProgress: (int sent, int total) {
          setState(() {
            progress = "${(sent / total * 100).toStringAsFixed(2)}%";
          });
        },
      );

      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Documento enviado com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        progress = "Upload complete";
      });
    } catch (e) {
      print("Upload error: $e");
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar o documento'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        progress = "Upload failed";
      });
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
              Text(
                "Documentos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 55, 226),
                  fontSize: 16,
                ),
              ),
              Text(
                "Selecione o tipo de documento",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "$fileName",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 55, 226),
                  fontSize: 16,
                ),
              ),
              Text(
                "$progress",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                    icon: const Icon(
                      EvaIcons.fileAdd,
                      color: Color.fromARGB(255, 34, 37, 199),
                    ),
                    onPressed: selectFile,
                    label: Text("Selecionar ficheiro"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton.icon(
                    icon: const Icon(
                      EvaIcons.upload,
                      color: Color.fromARGB(255, 34, 37, 199),
                    ),
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
*/

import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';

class Documentos extends StatefulWidget {
  const Documentos({super.key, required this.candidato});
  final Candidato candidato;

  @override
  State<Documentos> createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  String? _selectedType;
  late File selectedfilePath;
  String progress = "0%";
  String fileName = "";
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
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

    String uploadurl = 'http://$IP/api/Doc/upload?id=$codigo';

    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          selectedfilePath.path,
          filename: fileName,
        ),
      });

      await dio.post(
        uploadurl,
        data: formData,
        onSendProgress: (int sent, int total) {
          setState(() {
            progress = "${(sent / total * 100).toStringAsFixed(2)}%";
          });
        },
      );

      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Documento enviado com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        progress = "Upload complete";
      });
    } catch (e) {
      print("Upload error: $e");
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar o documento'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        progress = "Upload failed";
      });
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
              Text(
                "Documentos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 55, 226),
                  fontSize: 16,
                ),
              ),
              Text(
                "Selecione o tipo de documento",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "$fileName",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 55, 226),
                  fontSize: 16,
                ),
              ),
              Text(
                "$progress",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                    icon: const Icon(
                      EvaIcons.fileAdd,
                      color: Color.fromARGB(255, 34, 37, 199),
                    ),
                    onPressed: selectFile,
                    label: Text("Selecionar ficheiro"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton.icon(
                    icon: const Icon(
                      EvaIcons.upload,
                      color: Color.fromARGB(255, 34, 37, 199),
                    ),
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
