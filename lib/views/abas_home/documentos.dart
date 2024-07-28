import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

class Documentos extends StatefulWidget {
  const Documentos({super.key});

  @override
  State<Documentos> createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  var _selectedType;
  @override
  Widget build(BuildContext context) {
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
                  items: ["Certificado", "BI", "NUIT", "Declaração"]
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
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(EvaIcons.fileAdd,
                        color: Color.fromARGB(255, 34, 37, 199)),
                    onPressed: () {
                      // Define the action to be performed on button press
                      print('Carregar ficheiro pressed');
                    },
                    label: Text("Selecionar ficheiro"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton.icon(
                    icon: const Icon(EvaIcons.upload,
                        color: Color.fromARGB(255, 34, 37, 199)),
                    onPressed: () {
                      // Define the action to be performed on button press
                      print('Carregar ficheiro pressed');
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
