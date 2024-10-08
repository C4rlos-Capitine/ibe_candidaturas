import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:iconsax/iconsax.dart';
import 'package:radio_group_v2/radio_group_v2.dart';


enum identificacao { bi, passaporte}  


class Documento2 extends StatefulWidget {
  const Documento2({super.key, required this.candidato});
  final Candidato candidato;

  @override
  State<Documento2> createState() => _Documento2State();
}

class _Documento2State extends State<Documento2> {
  File? _biFile;
  File? _certificadoFile;
  File? _nuitFile;
  File? _fotoFile;
  String _biFileName = "";
  String _certificadoFileName = "";
  String _nuitName = "";
  String _fotoName = "";
  String progress = "0%";
  bool _isUploading = false; // Adicionamos um flag para controle de upload
  Dio dio = Dio();

 RadioGroupController myController = RadioGroupController();

  Future<void> pickFile(String field) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        if (field == 'bi') {
          _biFile = File(result.files.single.path!);
          _biFileName = result.files.single.name;
        } else if (field == 'certificado') {
          _certificadoFile = File(result.files.single.path!);
          _certificadoFileName = result.files.single.name;
        } else if (field == 'NUIT') {
          _nuitFile = File(result.files.single.path!);
          _nuitName = result.files.single.name;
        }else if(field == 'foto'){
          _fotoFile = File(result.files.single.path!);
          _fotoName = result.files.single.name;
        }
      });
    }
  }

  void uploadFile(int codigo, String field) async {
    File? file;
    String? fileName;
    late int tipo_ficheiro;

    if (field == 'bi') {
      file = _biFile;
      fileName = _biFileName;
      tipo_ficheiro = 1;
    } else if (field == 'certificado') {
      file = _certificadoFile;
      fileName = _certificadoFileName;
      tipo_ficheiro = 2;
    }else if(field == 'NUIT'){
      file = _nuitFile;
      fileName = _nuitName;
      tipo_ficheiro = 3;
    }else if(field == 'foto'){
      file = _fotoFile;
      fileName = _fotoName;
      tipo_ficheiro = 4;
    }

    if (file == null) {
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Nenhum ficheiro selecionado para $field.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      String url = 'http://$IP/api/FileUpload/upload?id=$codigo&tipo=$tipo_ficheiro'; // Substitua com o URL da sua API

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
        'codigo': codigo,
      });

      setState(() {
        _isUploading = true;
      });

      await dio.post(url, data: formData, onSendProgress: (int sent, int total) {
        setState(() {
          progress = "${((sent / total) * 100).toStringAsFixed(2)}%";
        });
      });

      setState(() {
        _isUploading = false;
      });

      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Ficheiro enviado com sucesso para $field!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print(e);
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Text('Falha no envio do ficheiro para $field.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
     String? identificacao; // Make sure this is declared
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 0,
              child: Text(
                "Carregamento de documentos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 55, 226),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Text("Doc. identificação"),
         
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 248, 245, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              
              children: [
                 RadioGroup(
                  controller: myController,
                  values: ["BI", "Passaporte"],
                  indexOfDefault: 0,
                  orientation: RadioGroupOrientation.horizontal,
                  decoration: RadioGroupDecoration(
                    spacing: 10.0,
                    labelStyle: TextStyle(
                      //color: Colors.blue,
                    ),
                    activeColor: Colors.blueAccent,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: Icon(Iconsax.card, color: Colors.blue[900]),
                        title: Text("BI/Passaporte:", style: TextStyle(color: Colors.blue[900])),
                        subtitle: Text(_biFileName.isEmpty ? "Selecione o documento" : _biFileName),
                        onTap: () => pickFile('bi'),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        EvaIcons.upload,
                        color: Colors.white,
                      ),
                      onPressed: () => uploadFile(widget.candidato.codigo, 'bi'),
                      label: Text("Enviar", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 34, 37, 199),
                      ),
                    ),
                  ],
                ),
              ],
            )
            
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 248, 245, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(Iconsax.card, color: Colors.blue[900]),
                    title: Text("NUIT:", style: TextStyle(color: Colors.blue[900])),
                    subtitle: Text(_nuitName.isEmpty ? "Selecione o documento" : _nuitName),
                    onTap: () => pickFile('NUIT'),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    EvaIcons.upload,
                    color: Colors.white,
                  ),
                  onPressed: () => uploadFile(widget.candidato.codigo, 'NUIT'),
                  label: Text("Enviar", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 34, 37, 199),
                  ),
                ),
              ],
            ),
            
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 248, 245, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(Iconsax.document, color: Colors.blue[900]),
                    title: Text("Certificado:", style: TextStyle(color: Colors.blue[900])),
                    subtitle: Text(_certificadoFileName.isEmpty ? "Selecione o documento" : _certificadoFileName),
                    onTap: () => pickFile('certificado'),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    EvaIcons.upload,
                    color: Colors.white,
                  ),
                  onPressed: () => uploadFile(widget.candidato.codigo, 'certificado'),
                  label: Text("Enviar", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 34, 37, 199),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 248, 245, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(Iconsax.document, color: Colors.blue[900]),
                    title: Text("Foto tipo passe:", style: TextStyle(color: Colors.blue[900])),
                    subtitle: Text(_fotoName.isEmpty ? "Selecione o documento" : _fotoName),
                    onTap: () => pickFile('foto'),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    EvaIcons.upload,
                    color: Colors.white,
                  ),
                  onPressed: () => uploadFile(widget.candidato.codigo, 'foto'),
                  label: Text("Enviar", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 34, 37, 199),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          if (_isUploading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: progress.isEmpty ? 0.0 : double.parse(progress.replaceAll('%', '')) / 100,
                    backgroundColor: Colors.grey[200],
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text('Progresso: $progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
