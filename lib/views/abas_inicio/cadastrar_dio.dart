import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/controllers/areaController.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ibe_candidaturas/controllers/editalController.dart';
import 'package:ibe_candidaturas/controllers/provinciaController.dart';
import 'package:ibe_candidaturas/http_response/http_response.dart';
import 'package:ibe_candidaturas/model/Area.dart';
import 'package:ibe_candidaturas/model/Edital.dart';
import 'package:ibe_candidaturas/model/Provincia.dart';
import 'package:iconsax/iconsax.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../controllers/EmailSendig.dart';


class CadastrarDio extends StatefulWidget {
  const CadastrarDio({super.key});

  @override
  State<CadastrarDio> createState() => _CadastrarDioState();
}

class _CadastrarDioState extends State<CadastrarDio> {
  TextEditingController _dobController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _apelidoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordControllerConfirm = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _telemovelController = TextEditingController();
  //TextEditingController _generoController = TextEditingController();
  TextEditingController _docController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
    TextEditingController _dataEmissaoController = TextEditingController();
  TextEditingController _dataValidadeController = TextEditingController();
    TextEditingController _naturalidadeController = TextEditingController();
  TextEditingController _ruaController = TextEditingController();
  TextEditingController _ocupacaoController = TextEditingController();
  TextEditingController _especialidadeController = TextEditingController();
  //List<Provincia>? _provincias;
  List<String> lista_prov =  ["Maputo Provincia", "Maputo Cidade", "Inhembane"];
  List <String> niveis = ["Médio","Téc. Médio","Licenciatura", "Mestrado", "Doutoramento"];

  List<Area>? areas;
  List<Provincia>? provincias;

    List<DropdownMenuItem<String>>? _dropdownMenuItems;

    List<DropdownMenuItem<String>>? _dropdownMenuItems_provincias;

    List<DropdownMenuItem<String>>? _dropdownMenuItems_Areas;
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

  String? _selectedGender;
  String? _selectetTipo;
  String? _selectedProvince;
  String? _selectedNivel;
  String? _selectedEdital;
  String? _selectedArea;
  String? edital;
  String? nomeEdital;
  String? nomeArea;
  late int _selectedIndexNivel;
  late int dia;
  late int mes;
  late int ano;
  late int dia_emissao;
  late int mes_emissao;
  late int ano_emissao;
  late int dia_validade;
  late int mes_validade;
  late int ano_validade;
  late int selectedIndex;
  late int _codedita;
  late int _codarea;



  void showErro(String descricao) {
    Fluttertoast.showToast(
      msg: descricao,
      backgroundColor: const Color.fromARGB(255, 231, 3, 3),
      fontSize: 25,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5
    );
  }

    List<Edital>? _edital;

  @override
  void initState() {
    super.initState();
    _loadEditais(); // Call the async method to load data
    _getAreas();
    _getProvincias();
  }

  // Asynchronous method to load data
  Future<void> _loadEditais() async {
    try {
      List<Edital>? editais = await getEditais();
      setState(() {
        _edital = editais;
        _dropdownMenuItems = editais?.map((edital) => DropdownMenuItem<String>(
          child: Text(edital.nome),

          value: edital.codedita.toString(),
        )).toList();
        if (_dropdownMenuItems != null && _dropdownMenuItems!.isNotEmpty) {
          //nomeEdital = _dropdownMenuItems!.first.value; // Set a default value if there are courses
        }
      });
    } catch (e) {
      print('Error loading cursos: $e');
    }
  }

  Future <void> _getProvincias() async{
    try{
      List<Provincia>? _provincias = await getProvincias();
      setState(() {
        provincias = _provincias;
        _dropdownMenuItems_provincias = provincias?.map((provincia) => DropdownMenuItem<String>(
            child: Text(provincia.provinc),

            value: provincia.codprovi.toString(),
          )).toList();
          if (_dropdownMenuItems_provincias != null && _dropdownMenuItems_provincias!.isNotEmpty) {
            _selectedProvince = _dropdownMenuItems_provincias!.first.value; 
          }
      });
    }catch(e){
      print(e);
    }

  }

  Future <void> _getAreas() async{
    try {
        List<Area>? _areas = await getAreas(1);
        setState(() {
          areas = _areas;
          _dropdownMenuItems_Areas = areas?.map((area) => DropdownMenuItem<String>(
            child: Text(area.nome),

            value: area.codarea.toString(),
          )).toList();
          if (_dropdownMenuItems_Areas != null && _dropdownMenuItems_Areas!.isNotEmpty) {
            //nomeEdital = _dropdownMenuItems_Areas!.first.value; // Set a default value if there are courses
          }
        });
      } catch (e) {
        print('Error loading cursos: $e');
      }
}

  void uploadFiles(String email) async {
  try {
    String url = 'http://$IP/api/Upload/upload?email=$email'; // Corrected URL construction

    FormData formData = FormData.fromMap({
      if (_biFile != null) 'bi': await MultipartFile.fromFile(_biFile!.path, filename: _biFileName),
      if (_nuitFile != null) 'nuit': await MultipartFile.fromFile(_nuitFile!.path, filename: _nuitName),
      if (_certificadoFile != null) 'certificado': await MultipartFile.fromFile(_certificadoFile!.path, filename: _certificadoFileName),
      if (_fotoFile != null) 'foto': await MultipartFile.fromFile(_fotoFile!.path, filename: _fotoName),
    });

    // Debugging: Print form data fields
    print(formData.fields);

    final response = await dio.post(url, data: formData, onSendProgress: (int sent, int total) {
      print("Total: $total, Sent: $sent");
    });

    // Check the response status
    if (response.statusCode == 200) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload successful!")),
      );
    } else {
      // Show error message based on response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: ${response.statusCode} - ${response.data}")),
      );
    }
  } catch (e) {
    print(e);
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Upload failed: $e")),
    );
  }
}
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
        } else if (field == 'nuit') {
          _nuitFile = File(result.files.single.path!);
          _nuitName = result.files.single.name;
        }else if(field == 'foto'){
          _fotoFile = File(result.files.single.path!);
          _fotoName = result.files.single.name;
        }
      });
    }
  }
  Widget _buildFileContainer(String title, String subtitle, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromARGB(255, 248, 245, 245),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading: Icon(Iconsax.card, color: Colors.blue[900]),
              title: Text(title, style: TextStyle(color: Colors.blue[900])),
              subtitle: Text(subtitle.isEmpty ? "Selecione o documento" : subtitle),
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }


Widget _textFieldContainer({
  required String label,
  required String hint,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  Icon? icon,
}) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(horizontal: 30),
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Color.fromARGB(255, 248, 245, 245),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: InputBorder.none,
        label: Text(label, style: TextStyle(color: Colors.blue[900])),
        icon: icon,
        hintText: hint,
      ),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
       body: ListView(
          children: [
            SizedBox(height: 10),
             Container(
              height: 50,
              child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  child: Text(
                    "Registo da candidatura",
                    style: TextStyle(
                        color: Color.fromARGB(255, 3, 44, 226),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  )),
            ),
            SizedBox(height: 10),
          _textFieldContainer(
            label: "Nome:",
            hint: "Escreva seu Nome",
            controller: _nomeController,
            keyboardType: TextInputType.name,
            icon: Icon(Icons.person_2_outlined, color: Colors.blue[900]),
          ),
          SizedBox(height: 10),
          _textFieldContainer(
            label: "Apelido:",
            hint: "Seu apelido",
            controller: _apelidoController,
            icon: Icon(Icons.person_2_outlined, color: Colors.blue[900]),
          ),
      SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Iconsax.document_1, color: Colors.blue[900]),
                  hintStyle: TextStyle(color: Colors.blue[900]),
                  labelText: "Tipo de documento.",
                  labelStyle: TextStyle(color: Colors.blue[900]),
                ),
                value: _selectetTipo,
                items: ["BI", "Passaport"]
                    .map((label) => DropdownMenuItem(
                          child: Text(label, style: TextStyle(color: Colors.blue[900]),),
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
            SizedBox(height: 20),
            _textFieldContainer(
              label: "BI:",
              hint: "Número de BI",
              controller: _docController,
              keyboardType: TextInputType.number,
              icon: Icon(Iconsax.card, color: Colors.blue[900]),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      dia_emissao = pickedDate.day;
                      mes_emissao = pickedDate.month;
                      ano_emissao = pickedDate.year;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      dia_validade = pickedDate.day;
                      mes_validade = pickedDate.month;
                      ano_validade = pickedDate.year;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                  icon: Icon(Iconsax.man, color: Colors.blue[900]),
                  labelText: "Gênero",
                  hintStyle:TextStyle(color: Colors.blue[900]),
                  labelStyle: TextStyle(color: Colors.blue[900]),
                ),
                value: _selectedGender,
                items: ["Masculino", "Feminino"]
                    .map((label) => DropdownMenuItem(
                          child: Text(label, style: TextStyle(color: Colors.blue[900]),),
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
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                  hintStyle:TextStyle(color: Colors.blue[900]),
                  labelStyle: TextStyle(color: Colors.blue[900]),
                ),
                //value: _selectedProvince,
                items: _dropdownMenuItems_provincias,
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
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                  icon: Icon(Icons.school, color: Colors.blue[900]),
                  labelText: "Nível Académico",
                  hintStyle:TextStyle(color: Colors.blue[900]),
                  labelStyle: TextStyle(color: Colors.blue[900]),
                ),
                value: _selectedNivel,
                items: niveis
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
                    _selectedNivel = value;
                    print(_selectedNivel);
                    _selectedIndexNivel = niveis.indexOf(_selectedNivel!);
                    print(
                        "Selected item: $_selectedNivel, Index: $_selectedIndexNivel");
                  });
                },
              ),
            ),
            Container(
              
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 2),
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
                    labelText: "Selecione o Edital",
                    hintStyle:TextStyle(color: Colors.blue[900],),
                    labelStyle: TextStyle(color: Colors.blue[900]),
                  ),
                value: nomeEdital,
                items: _dropdownMenuItems,
                onChanged: (value) {
                  setState(() {
                    try{
                      print("value: $value");
                      nomeEdital = value;
                      print("value: $nomeEdital");
                      //print("value: "+_selectedEdital);
                    
                    }catch(e){
                      print(e);
                    }
                    
                  });
                },
              ),
            ),
            SizedBox(height: 5,),
            Container(
              alignment: Alignment.center,
               padding: EdgeInsets.symmetric(horizontal: 2),
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
                value: nomeArea,
                items: _dropdownMenuItems_Areas,
                onChanged: (value) {
                  setState(() {
                    try{
                      print(value);
                      nomeArea = value;
                      print("area: $nomeArea");

                    
                    }catch(e){
                      print(e);
                    }
                    
                  });
                },
              ),
            ),

            SizedBox(height: 10,),
            _textFieldContainer(
              label: "Especialidade:",
              hint: "Informe a especialidade.",
              controller: _especialidadeController,
            ),
            SizedBox(height: 20),
            _textFieldContainer(
              label: "Naturalidade:",
              hint: "Natural de...",
              controller: _naturalidadeController,
              icon: Icon(Icons.location_city_outlined, color: Colors.blue[900]),
            ),
            SizedBox(height: 10),
            _textFieldContainer(
              label: "Rua:",
              hint: "Rua",
              controller: _ruaController,
              icon: Icon(Icons.streetview_outlined, color: Colors.blue[900]),
            ),
            SizedBox(height: 20),
            _textFieldContainer(
              label: "Ocupação:",
              hint: "Sua ocupação",
              controller: _ocupacaoController,
              icon: Icon(Iconsax.task, color: Colors.blue[900]),
            ),
            SizedBox(height: 20),
            _textFieldContainer(
              label: "Celular:",
              hint: "+258 00000",
              controller: _telemovelController,
              keyboardType: TextInputType.number,
              icon: Icon(Icons.phone_android, color: Colors.blue[900]),
            ),
            SizedBox(height: 20),
            _textFieldContainer(
              label: "Telefone:",
              hint: "+258 21 00000",
              controller: _telefoneController,
              keyboardType: TextInputType.number,
              icon: Icon(Icons.phone, color: Colors.blue[900]),
            ),
            SizedBox(height: 20,),
           Column(
          children: [
            _buildFileContainer("BI/Passaporte:", _biFileName, () => pickFile('bi')),
            _buildFileContainer("NUIT:", _nuitName, () => pickFile('nuit')),
            _buildFileContainer("Certificado:", _certificadoFileName, () => pickFile('certificado')),
            _buildFileContainer("Foto tipo passe:", _fotoName, () => pickFile('foto')),
            SizedBox(height: 20),
          ],
        ),
          SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Senha:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Icons.password_sharp, color: Colors.blue[900]),
                  hintText: "********",
                ),
              ),
            ),
            SizedBox(height: 25,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                obscureText: true,
                controller: _passwordControllerConfirm,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Confirmar:", style: TextStyle(color: Colors.blue[900]),),
                  icon: Icon(Iconsax.password_check, color: Colors.blue[900]),
                  hintText: "********",
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
                  
                  if(_biFileName.isEmpty || _biFileName == null){
                    showErro("Adicione BI");
                    erro_validacao = true;
                    return;
                  }
                  if(_nuitName.isEmpty || _biFileName == null){
                    showErro("Adicione nuit");
                    erro_validacao = true;
                    return;
                  }
                  if(_certificadoFileName.isEmpty || _biFileName == null){
                    showErro("Adicione certificado");
                    erro_validacao = true;
                    return;
                  }

                  if(_fotoName.isEmpty || _biFileName == null){
                    showErro("Adicione adicione foto");
                    erro_validacao = true;
                    return;
                  }

                  if (_nomeController.text.isEmpty) {
                    showErro("Campo nome Vazio");
                    erro_validacao = true;
                    return;
                  }
                  if (_apelidoController.text.isEmpty) {
                    showErro("Campo apelido Vazio");
                    erro_validacao = true;
                    return;
                  }
                  if (_docController.text.isEmpty) {
                    showErro("Campo BI/Passaporte Vazio");
                    erro_validacao = true;
                    return;
                  }
                  if (_passwordController.text.isEmpty) {
                    showErro("Campo da senha Vazio");
                    erro_validacao = true;
                    return;
                  }
                  if (_passwordControllerConfirm.text.isEmpty) {
                    showErro("Campo confirmar a senha Vazio");
                    erro_validacao = true;
                    return;
                  }
                  if (_passwordController.text !=
                      _passwordControllerConfirm.text) {
                    showErro(
                        "A senha informada não é igual a do campo confirmar");
                    erro_validacao = true;
                    return;
                  }
                  if (_dataController.text.isEmpty) {
                    showErro("Data de nascimento não informada");
                    erro_validacao = true;
                    return;
                  }
                  if(_especialidadeController.text.isEmpty){
                    showErro("Especialidade não informada");
                    erro_validacao = true;
                    return;
                  }
                  if(nomeArea!.isEmpty){
                    showErro("Aréa de estudo não selecionada");
                    erro_validacao = true;
                    return;
                  }
                  if(nomeEdital!.isEmpty){
                    showErro("Edital não selecionado");
                    erro_validacao = true;
                    return;
                  }
                  if(_naturalidadeController.text.isEmpty){
                    showErro("Naturalidade não informada");
                    erro_validacao = true;
                    return;
                  }
                  if(_ocupacaoController.text.isEmpty){
                    showErro("Ocupação não informada");
                    erro_validacao = true;
                    return;
                  }
                  if(_dataEmissaoController.text.isEmpty){
                    showErro("Data de emissão do BI/Passaporte não informada");
                    erro_validacao = true;
                    return;
                  }
                  if(_dataValidadeController.text.isEmpty){
                    showErro("Data de validade do BI/Passaporte não informada");
                    erro_validacao = true;
                    return;
                  }
                    RegExp emailRegExp = RegExp(
                      r'^[^@]+@[^@]+\.[^@]+',
                    );
                  if (emailRegExp.hasMatch(_emailController.text)) {
                      print("Email válido.");
                    } else {
                      print("Email inválido.");
                      showErro("Email deve conter @");
                      erro_validacao = true;
                  
                      return;
                    }
                  if (erro_validacao == false) {
                        ResquestResponse response = await registar2(
                        _nomeController.text,
                        _apelidoController.text,
                        _emailController.text,
                        _passwordController.text,
                        _telemovelController.text,
                        _telefoneController.text,
                        _docController.text,
                        _selectetTipo,
                        _selectedGender,
                        _dataController.text,
                        dia,
                        mes,
                        ano,
                        _selectedProvince,
                        _naturalidadeController.text,
                        _ruaController.text,
                        _ocupacaoController.text,
                        _dataEmissaoController.text,
                        _dataValidadeController,
                        dia_emissao,
                        mes_emissao,
                        ano_emissao,
                        dia_validade,
                        mes_validade,
                        ano_validade,
                        nomeEdital,
                        nomeArea,
                        _especialidadeController.text, _selectedIndexNivel);
                    if (response.success) {
                      try{

                      }catch(e){
                        print(e);
                      }
                      print(response.message);                       
                        await ConfirmEnrollment(_emailController.text, _passwordController.text, _nomeController.text);
                        uploadFiles(_emailController.text);
                        PanaraInfoDialog.show(
                          context,
                          title: "Olá!!",
                          message: "'Msg: ${response.message} ${response.statuscode}'",
                          buttonText: "Okay",
                          onTapDismiss: () {
                            Navigator.pop(context);
                            downloadAndOpenFile(_emailController.text);
                          },
                          panaraDialogType: PanaraDialogType.success,
                        );                    
                    } else {
                      try{
                         print("Erro de conexao.");
                        PanaraInfoDialog.showAnimatedGrow(
                          context,
                          title: "Mensagem de Erro",
                          message: 'Msg: ${response.message} ${response.statuscode}',
                          buttonText: "Okay",
                          onTapDismiss: () {
                            Navigator.pop(context);
                          },
                          panaraDialogType: PanaraDialogType.error,
                        );
                      }catch(e){
                        print(e);
                      }                      
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
                          fixedSize: Size(300, 50)
                        ),
              ),
            ),
          ],
        )
    );
  }
}