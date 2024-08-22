import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ibe_candidaturas/controllers/provinciaController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/model/Provincia.dart';
import 'package:iconsax/iconsax.dart';

class EditarDados extends StatefulWidget {

  const EditarDados({super.key, required this.candidato});
  final Candidato candidato;
  @override
  State<EditarDados> createState() => _EditarDadosState();
}

class _EditarDadosState extends State<EditarDados> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _apelidoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordControllerConfirm = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _telemovelController = TextEditingController();
  TextEditingController _generoController = TextEditingController();
  TextEditingController _docController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _dataEmissaoController = TextEditingController();
  TextEditingController _dataValidadeController = TextEditingController();
  TextEditingController _naturalidadeController = TextEditingController();
  TextEditingController _ruaController = TextEditingController();
  TextEditingController _ocupacaoController = TextEditingController();

  //List<Provincia>? _provincias;
  List<String> lista_prov = ["Maputo Provincia", "Maputo Cidade", "Inhembane"];

  String? _selectedGender;
  String? _selectetTipo;
  String? _selectedProvince;
  //String? _provincia;
  late int dia;
  late int mes;
  late int ano;
  late int selectedIndex;

  void showErro(String descricao) {
    Fluttertoast.showToast(
        msg: descricao,
        backgroundColor: const Color.fromARGB(255, 231, 3, 3),
        fontSize: 25,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    setState(() {
      _nomeController.text = widget.candidato.nome;
      _apelidoController.text = widget.candidato.apelido;
      _docController.text = widget.candidato.identificacao.toString();
      _telefoneController.text = widget.candidato.telefone;
      _telemovelController.text = widget.candidato.telemovel;
      _dataController.text = widget.candidato.datadena.toString();
      //_ruaController.text = widget.candidato
       _dataEmissaoController.text = widget.candidato.data_emissao.substring(0, widget.candidato.data_emissao.length - 9);
       _dataValidadeController.text = widget.candidato.data_validade.substring(0, widget.candidato.data_validade.length - 9);
       _dataController.text = widget.candidato.datadena.substring(0, widget.candidato.datadena.length - 9);
       _generoController.text = widget.candidato.genero;
       selectedIndex = widget.candidato.codprovi;
       _naturalidadeController.text = widget.candidato.naturalidade;
       _emailController.text = widget.candidato.email;
       _ruaController.text = widget.candidato.rua;
       _ocupacaoController.text = widget.candidato.ocupacao;
    });
    

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "IBE - Portal do Candidatos",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 34, 88, 236),
          iconTheme: IconThemeData(color: Colors.blue[900]),
        ),
        body: ListView(
          children: [
            SizedBox(height: 10),
             Container(
              height: 50,
              child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  child: Text(
                    "Editar dados  do Candidato",
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
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _nomeController,
                enableSuggestions: false,
                readOnly: true,
                //maxLength: 50,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Nome:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Icons.person_2_outlined, color: Colors.blue[900]),
                  hintText: "Escreva seu Nome",
                ),
                onChanged: (value) {
                  print("onChanged");
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: _apelidoController,
                enableSuggestions: false,
                readOnly: true,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  border: InputBorder.none,
                  label: Text("Apelido:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Icons.person_2_outlined, color: Colors.blue[900]),
                  hintText: "Seu apelido",
                ),
              ),
            ),
            
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: _docController,
                keyboardType: TextInputType.number,
                enableSuggestions: false,
                readOnly: true,
                //maxLength: 13,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("BI:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Iconsax.card, color: Colors.blue[900]),
                  hintText: "Numero de BI",
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _dataEmissaoController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Data de emissão:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Iconsax.calendar, color: Colors.blue[900]),
                  hintText: "data dd/mm/aaaa",
                  
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Colors.blue[900], // Color for the header and selected date
                          cardColor: Colors.blue[900],
                          canvasColor: Colors.blue[900],
                          dialogBackgroundColor: Colors.blue[900],
                          colorScheme: ColorScheme(brightness: Brightness.light, primary: Color.fromARGB(255, 5, 85, 233), onPrimary: Colors.black, secondary: Colors.blue, onSecondary: Colors.black, error: Colors.redAccent, onError: Colors.redAccent, surface: Colors.white, onSurface: Colors.black),
                          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button text color
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(foregroundColor: Colors.blue[900]), // Color for text buttons
                          ),
                          primaryColorLight: Colors.white, // Background color
                          //dialogBackgroundColor: Colors.white, // Background color of the dialog
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _dataEmissaoController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      dia = pickedDate.day;
                      mes = pickedDate.month;
                      ano = pickedDate.year;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _dataValidadeController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Válido até:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Iconsax.calendar, color: Colors.blue[900]),
                  hintText: "data dd/mm/aaaa",
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Colors.blue[900], // Color for the header and selected date
                          cardColor: Colors.blue[900],
                          canvasColor: Colors.blue[900],
                          dialogBackgroundColor: Colors.blue[900],
                          colorScheme: ColorScheme(brightness: Brightness.light, primary: Color.fromARGB(255, 5, 85, 233), onPrimary: Colors.black, secondary: Colors.blue, onSecondary: Colors.black, error: Colors.redAccent, onError: Colors.redAccent, surface: Colors.white, onSurface: Colors.black),
                          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button text color
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(foregroundColor: Colors.blue[900]), // Color for text buttons
                          ),
                          primaryColorLight: Colors.white, // Background color
                          //dialogBackgroundColor: Colors.white, // Background color of the dialog
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _dataValidadeController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      dia = pickedDate.day;
                      mes = pickedDate.month;
                      ano = pickedDate.year;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _dataController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Data de nascimento:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Iconsax.calendar, color: Colors.blue[900]),
                  hintText: "data dd/mm/aaaa",
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Colors.blue[900], // Color for the header and selected date
                          cardColor: Colors.blue[900],
                          canvasColor: Colors.blue[900],
                          dialogBackgroundColor: Colors.blue[900],
                          colorScheme: ColorScheme(brightness: Brightness.light, primary: Color.fromARGB(255, 5, 85, 233), onPrimary: Colors.black, secondary: Colors.blue, onSecondary: Colors.black, error: Colors.redAccent, onError: Colors.redAccent, surface: Colors.white, onSurface: Colors.black),
                          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button text color
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(foregroundColor: Colors.blue[900]), // Color for text buttons
                          ),
                          primaryColorLight: Colors.white, // Background color
                          //dialogBackgroundColor: Colors.white, // Background color of the dialog
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _dataController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      dia = pickedDate.day;
                      mes = pickedDate.month;
                      ano = pickedDate.year;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: _generoController,
                keyboardType: TextInputType.number,
                enableSuggestions: false,
                readOnly: true,
                //maxLength: 13,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Genero:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Iconsax.man, color: Colors.blue[900]),
                  
                 
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.place_outlined, color: Colors.blue[900]),
                  labelText: "Provincia",
                  helperText: widget.candidato.provincia,
                  hintStyle:TextStyle(color: Colors.blue[900]),
                  labelStyle: TextStyle(color: Colors.blue[900]),
                ),
                value: _selectedProvince,
                items: lista_prov
                    .asMap()
                    .map((index, label) => MapEntry(
                          index,
                          DropdownMenuItem(
                            child: Text(label,  style:TextStyle(color: Colors.blue[900]),),
                            value: label,
                          ),
                        ))
                    .values
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvince = value;
                    print(_selectedProvince);
                    selectedIndex = lista_prov.indexOf(_selectedProvince!);
                    print(
                        "Selected item: $_selectedProvince, Index: $selectedIndex");
                  });
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _naturalidadeController,
                keyboardType: TextInputType.text,
                enableSuggestions: false,
                readOnly: true,
               // maxLength: 25,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Naturalidade:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Icons.location_city_outlined, color: Colors.blue[900]),
                  hintText: "Natural de...",
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _ruaController,
                keyboardType: TextInputType.text,
                //maxLength: 25,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Rua:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Icons.streetview_outlined, color: Colors.blue[900]),
                  hintText: "Rua",
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _ocupacaoController,
                keyboardType: TextInputType.text,
                //maxLength: 25,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Ocupação:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Iconsax.task, color: Colors.blue[900]),
                  hintText: "Sua ocupação",
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _telemovelController,
                keyboardType: TextInputType.number,
                //maxLength: 9,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Celular:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Icons.phone_android, color: Colors.blue[900]),
                  hintText: "+258 00000",
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _telefoneController,
                keyboardType: TextInputType.number,
                //maxLength: 9,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Telefone:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Icons.phone, color: Colors.blue[900]),
                  hintText: "+258 21 00000",
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                 enableSuggestions: false,
                readOnly: true,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Email:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Icons.email_outlined, color: Colors.blue[900]),
                  hintText: "email_nome@domain",
                ),
              ),
            ),
            
            SizedBox(height: 25,),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () async {
                  bool erro_validacao = false;
                  if (_nomeController.text.isEmpty) {
                    showErro("Campo nome Vazio");
                    erro_validacao = true;
                  }
                  if (_apelidoController.text.isEmpty) {
                    showErro("Campo apelido Vazio");
                    erro_validacao = true;
                  }
                  if (_docController.text.isEmpty) {
                    showErro("Campo BI/Passaporte Vazio");
                    erro_validacao = true;
                  }
                  if (_passwordController.text.isEmpty) {
                    showErro("Campo da senha Vazio");
                    erro_validacao = true;
                  }
                  if (_passwordControllerConfirm.text.isEmpty) {
                    showErro("Campo confirmar a senha Vazio");
                    erro_validacao = true;
                  }
                  if (_passwordController.text !=
                      _passwordControllerConfirm.text) {
                    showErro(
                        "A senha informada não é igual a do campo confirmar");
                    erro_validacao = true;
                  }
                  if (_dataController.text.isEmpty) {
                    showErro("Data de nascimento não informada");
                    erro_validacao = true;
                  }
                  if (erro_validacao == false) {
                    bool resp = await registar(
                        _nomeController.text,
                        _apelidoController.text,
                        _emailController.text,
                        _passwordController.text,
                        _telemovelController.text,
                        _telefoneController.text,
                        _docController.text,
                        1,
                        _selectedGender,
                        _dataController.text,
                        dia,
                        mes,
                        ano,
                        selectedIndex,
                        _naturalidadeController.text,
                        _ruaController.text,
                        _ocupacaoController.text
                        );
                    if (resp) {
                      print(resp.toString());
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          content: Text('Registado com sucesso'),
                          backgroundColor: Color.fromARGB(255, 8, 224, 134),
                        ),
                      );
                      //print response from server
                    } else {
                      print("Erro de conexao.");
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao enviar os dados'),
                          backgroundColor: Color.fromARGB(255, 235, 77, 3),
                        ),
                      );
                      
                    }
                  }
                },
                child: Text(
                  "Submeter",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
              ),
            ),
          ],
        )
      );
  }
}