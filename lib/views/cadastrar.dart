import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ibe_candidaturas/controllers/provinciaController.dart';
import 'package:ibe_candidaturas/model/Provincia.dart';

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
  TextEditingController _passwordControllerConfirm = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _telemovelController = TextEditingController();
  //TextEditingController _generoController = TextEditingController();
  TextEditingController _docController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  List<Provincia>? _provincias;
  List<String>? lista_prov;

  String? _selectedGender;
  String? _selectetTipo;
  late int dia;
  late int mes;
  late int ano;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProvincias();
  }

  void _fetchProvincias() async{
    List<Provincia> provincia = (await getProvincias()).cast<Provincia>();
    setState(() {
      _provincias = provincia;
      lista_prov =  provincia?.map((prov) => prov.provinc).toList(); 
      print(lista_prov);
    });
  }

  void showErro(String descricao) {
    Fluttertoast.showToast(
      msg: descricao,
      backgroundColor: const Color.fromARGB(255, 231, 3, 3),
      fontSize: 25,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5
    );
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
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Ajuda e Suporte'),
                  content: const Text('Seção com perguntas frequentes e respostas, e Informações de contato para suporte técnico e administrativo. Clique OK para continuar'),
                  actions: <Widget>[
                    

                  ],
                ),
              ),
              icon: Icon(Icons.help, color: Colors.white))
          ],
          iconTheme: IconThemeData(color: Colors.blue[900]),
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
                maxLength: 50,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("NOME:"),
                  icon: Icon(Icons.person, color: Colors.blue[900]),
                  hintText: "Escreva seu Nome",
                ),
                onChanged: (value) {
                  print("onChanged");
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: _apelidoController,
                maxLength: 25,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("APELIDO:"),
                  icon: Icon(Icons.person, color: Colors.blue[900]),
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
                keyboardType: TextInputType.number,
                maxLength: 13,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("BI:"),
                  icon: Icon(Icons.perm_identity, color: Colors.blue[900]),
                  hintText: "Numero de BI",
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: _dataController,
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
                      _dataController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          dia = pickedDate.day; mes = pickedDate.month; ano = pickedDate.year;
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
                keyboardType: TextInputType.number,
                maxLength: 9,
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
                keyboardType: TextInputType.number,
                maxLength: 9,
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
                controller: _passwordController,
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
                controller: _passwordControllerConfirm,
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
                onPressed: () async{
                  bool erro_validacao = false; 
                  if(_nomeController.text.isEmpty){
                    showErro("Campo nome Vazio");
                    erro_validacao = true;
                  }
                  if(_apelidoController.text.isEmpty){
                    showErro("Campo apelido Vazio");
                    erro_validacao = true;
                  }
                  if(_docController.text.isEmpty){
                    showErro("Campo BI/Passaporte Vazio");
                    erro_validacao = true;
                  }
                  if(_passwordController.text.isEmpty){
                    showErro("Campo da senha Vazio");
                    erro_validacao = true;
                  }
                  if(_passwordControllerConfirm.text.isEmpty){
                    showErro("Campo confirmar a senha Vazio");
                    erro_validacao = true;
                  }
                  if(_passwordController.text != _passwordControllerConfirm.text){
                    showErro("A senha informada não é igual a do campo confirmar");
                    erro_validacao = true;
                  }
                  if(_dataController.text.isEmpty){
                    showErro("Data de nascimento não informada");
                    erro_validacao = true;
                  }
                  if(erro_validacao==false){
                    bool resp = await registar(_nomeController.text, _apelidoController.text,_emailController.text,_passwordController.text,_telemovelController.text, _telefoneController.text,_docController.text,1, _selectedGender, _dataController.text, dia, mes, ano);
                    if(resp){
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
                      }
                  }

                  
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
        )
    );
  }
}
