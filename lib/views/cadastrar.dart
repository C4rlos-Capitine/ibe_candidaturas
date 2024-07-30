import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _dobController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _apelidoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _telemovelController = TextEditingController();
  //TextEditingController _generoController = TextEditingController();
  TextEditingController _docController = TextEditingController();
  
  String? _selectedGender;
  String? _selectetTipo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          "IBE - Portal Candidato",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Container(
            height: 50,
            child: Card(
                elevation: 4.0,
                child: Text(
                  "Cadastro de Candidato",
                  style: TextStyle(
                      color: Color.fromARGB(255, 3, 44, 226),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                )),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("NOME:"),
                icon: Icon(Icons.people, color: Colors.blue[900]),
                hintText: "Escreva seu Nome",
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: _apelidoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("APELIDO:"),
                icon: Icon(Icons.people, color: Colors.blue[900]),
                hintText: "Escreva o email",
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.document_scanner, color: Colors.blue[900]),
                labelText: "TIPO DOC.",
              ),
              value: _selectetTipo,
              items: ["BI", "PASSAPORTE"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectetTipo = value;
                  print(_selectetTipo);
                });
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: _docController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("BI:"),
                icon: Icon(Icons.people, color: Colors.blue[900]),
                hintText: "Numero de BI",
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("DATA DE NASCIMENTO:"),
                icon: Icon(Icons.date_range, color: Colors.blue[900]),
                hintText: "data dd/mm/aaaa",
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
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.man, color: Colors.blue[900]),
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
                  print(_selectedGender);
                });
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: _telemovelController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("CELULAR:"),
                icon: Icon(Icons.phone_android, color: Colors.blue[900]),
                hintText: "+258 00000",
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: _telefoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("TELEFONE:"),
                icon: Icon(Icons.phone, color: Colors.blue[900]),
                hintText: "+258 21 00000",
              ),
            ),
          ),
           Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("EMAIL:"),
                icon: Icon(Icons.phone, color: Colors.blue[900]),
                hintText: "+email_nome@domain",
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              obscureText: true,
            
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("SENHA:"),
                icon: Icon(Icons.password, color: Colors.blue[900]),
                hintText: "********",
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("CONFIRMAR:"),
                icon: Icon(Icons.password, color: Colors.blue[900]),
                hintText: "********",
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                registar(_nomeController.text, _apelidoController.text, _emailController.text, _passwordController.text, _telemovelController.text, _telefoneController.text, _docController.text, 1, _selectedGender);
                //Navigator.pushNamed(context, "/cadastro");
                /*if(done == true){
                    Fluttertoast.showToast(
                      msg: "Utilizador registado com sucesso",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(255, 3, 235, 34),
                      textColor: Colors.white,
                      fontSize: 16.0
                    );
                }else{
                   Fluttertoast.showToast(
                      msg: "Falha",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(255, 3, 235, 34),
                      textColor: Colors.white,
                      fontSize: 16.0
                    );
                }*/
              },
              child: Text(
                "Submeter",
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
