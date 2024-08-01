import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:path/path.dart';
import 'dart:io'; // Update the import statement

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Documentos extends StatefulWidget {
  const Documentos({super.key, required this.candidato});
  final Candidato candidato;

  @override
  State<Documentos> createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  var _selectedType;
  late File selectedfilePath = File('');
  String progress = "";
  var fileName = "";
  Dio dio = Dio();
  late var response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.candidato);
  }

  void selectFile() async {
    String nomeFicheiro = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );
    print(result);
    if (result != null) {
      setState(() {
        selectedfilePath = File(result.files.single.path!);
        print(selectedfilePath);
        setState(() {
          fileName = selectedfilePath.path;
        });
      });
    }
  }

  

  void uploadFile(codigo) async {
    String uploadurl = 'http://localhost:5284/api/Doc/upload?id=$codigo';
    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
          selectedfilePath.path,
          filename: basename(selectedfilePath.path),
          
        //show only filename from path
      ),
      "codcandi": codigo
      //
    });

    try{
      response = await dio.post(uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent/total*100).toStringAsFixed(2);

        setState(() {
          progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
          //update the progress
        });
      });

      if(response.statusCode == 200 || response.statusCode == 201){
      print(response.toString());
      ScaffoldMessenger.of(this.context).showSnackBar(
      SnackBar(
          content: Text('Documento enviado com sucesso'),
          backgroundColor: Color.fromARGB(255, 8, 224, 134),
        ),
      );
      //print response from server
    }else{
      print("Erro de conexao.");
      ScaffoldMessenger.of(this.context).showSnackBar(
      SnackBar(
        content: Text('Erro: ${response.statusMessage}'),
        backgroundColor: Color.fromARGB(255, 235, 77, 3),
      ),
    );
    }
    }catch(e){
      ScaffoldMessenger.of(this.context).showSnackBar(
      SnackBar(
        content: Text('Erro: ${response.statusMessage}'),
        backgroundColor: Color.fromARGB(255, 235, 77, 3),
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
              
              Text("Selecione o tipo de documento", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("$fileName", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 55, 226), fontSize: 16)),
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
                    onPressed: () {
                      selectFile();
                    },
                    label: Text("Selecionar ficheiro"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton.icon(
                    icon: const Icon(EvaIcons.upload,
                        color: Color.fromARGB(255, 34, 37, 199)),
                    onPressed: () {
                      // Define the action to be performed on button press
                      uploadFile(candidato.codigo);
                    },
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
