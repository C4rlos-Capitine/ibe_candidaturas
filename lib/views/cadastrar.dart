import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _dobController = TextEditingController();
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text("IBE"),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView(
        children: [
          Container(
            height: 50,
            child: Card(
                elevation: 4.0,
                child: Text(
                  "Cadastro de Candidato",
                  textAlign: TextAlign.center,
                )),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("NOME:"),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("APELIDO:"),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("BI:"),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            child: TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("DATA DE NASCIMENTO:"),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  setState(() {
                    _dobController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  });
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "GÊNERO",
              ),
              value: _selectedGender,
              items: ["Masculino", "Feminino", "Outro"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cadastro");
              },
              child: Text("Cadastrar"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
