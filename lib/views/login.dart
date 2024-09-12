import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/local_storage/storageManagment.dart'; 

import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';

import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:iconsax/iconsax.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _senha = TextEditingController();
  final TextEditingController _email = TextEditingController();
  bool _isLoading = false;

Future<void> _handleLogin() async {
  // Validação dos campos
  if (_email.text.isEmpty || _senha.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Preencha todos os campos'),
        backgroundColor: Color.fromARGB(255, 235, 77, 3),
      ),
    );
    return;
  }

  // Mostrar carregamento
  setState(() {
    _isLoading = true;
  });

  // Verificar a conexão com a internet
  bool connected = await _checkNetworkStatus();
  if (!connected) {
    // Mostrar mensagem de erro se não estiver conectado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verifique se o wifi ou dados estão ligados'),
        backgroundColor: Color.fromARGB(255, 235, 77, 3),
      ),
    );
    setState(() {
      _isLoading = false;
    });
    return;
  }

  // Tentar fazer login via internet
  bool internetLoginSuccess = false;
  Candidato? candidato;

  try {
    internetLoginSuccess = await login(_email.text, _senha.text);
    if (internetLoginSuccess) {
      candidato = await getData(_email.text, _senha.text);
    }
  } catch (e) {
    print('Error during internet login: $e');
  }

  // Se o login via internet falhar, tentar login local
  if (!internetLoginSuccess) {
    candidato = await attemptLocalLogin(_email.text, _senha.text);
    print(candidato?.nome);
    if (candidato == null) {
      PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Mensagem de Erro",
        message: "Dados incorectos.",
        buttonText: "Okay",
        color: Colors.white,
        onTapDismiss: () {
          Navigator.pop(context);
        },
        panaraDialogType: PanaraDialogType.error,
      );
    }
  }

  // Navegar para a tela inicial se o login for bem-sucedido
  if (candidato != null) {
    Navigator.pushNamed(context, "/home", arguments: candidato);
  }

  // Ocultar carregamento
  setState(() {
    _isLoading = false;
  });
}

Future<bool> _checkNetworkStatus() async {
  try {
    final response = await isConnected();
    print('Network Status: ${response.state}');
    print('Message: ${response.mesg}');
    return response.state;
  } catch (error) {
    print('Error: $error');
    return false;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(

            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Image.asset('assets/images/logotipo_header.png'),
          ),
         
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Text("Login", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 15),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 248, 245, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(
                border: InputBorder.none,
                hoverColor: Colors.blue[900],
                label: Text("Email"),
                icon: Icon(Icons.mail_outline, color: Colors.blue[900]),
                hintText: "Email",
                labelStyle: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
           padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 248, 245, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _senha,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Text("Senha"),
                icon: Icon(Icons.key_outlined, color: Colors.blue[900]),
                hintText: "Senha",
                labelStyle: TextStyle(color: Colors.blue[900]),
                hoverColor: Colors.blue[900],
              ),
              
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          fixedSize: Size(300, 50)
                        ),
                        child: Text(
                          "Entrar",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        
                      ),
                      SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
