/*import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  TextEditingController _senha = TextEditingController();
  TextEditingController _email = TextEditingController();
  late Candidato candidato;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
      
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Container(
           
            //padding: EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.all(40), // Adiciona padding ao Container
              child: Image.asset('assets/images/ibe_moz.png'),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Login",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900], decorationColor: Colors.blue[900])
                ),
            ],)
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(
                hoverColor: Colors.blue[900],
                fillColor: Colors.blue[900],
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue), 
                  
                ),
                label: Text("Email"),
                icon: Icon(Icons.mail, color: Colors.blue[900]),
                hintText: "Escreva o email",
                labelStyle: new TextStyle(
                    color: Colors.blue[900],decorationColor: Colors.blue[900]
                )
                // labelText: "Email"
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: TextFormField(
              controller: _senha,
              obscureText: true,
              decoration: InputDecoration(
                hoverColor: Colors.blue[900],
                fillColor: Colors.blue[900],
                focusColor: Colors.blue[900],
                border: OutlineInputBorder(),
                label: Text("Senha"),
                icon: Icon(Icons.password, color: Colors.blue[900]),
                hintText: "Escreva a senha",
                labelStyle: new TextStyle(
                    color: Colors.blue[900], decorationColor: Colors.blue[900]
                )
                //labelText: "Senha"
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                      bool resp = await login(_email.text, _senha.text);
                      print('Login response: $resp'); // Debug print
                      if (!resp) {
                        print('Displaying SnackBar'); // Debug print
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Dados incorrectos'),
                            backgroundColor: Color.fromARGB(255, 235, 77, 3),
                          ),
                        );
                      }else{
                        candidato = await getData(_email.text, _senha.text);
                        Navigator.pushNamed(context, "/home", arguments: candidato);
                      }
                    },

                  child: Text(
                    "Autenticar",
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/cadastro");
                  },
                  child: Text(
                    "Inscreva - se",
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                  ),
                ),
              ],
            ),
          )
        ]),
    );
  }
}
*/
import 'package:flutter/material.dart';
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
    setState(() {
      _isLoading = true;
    });

    bool internetLoginSuccess = false;
    Candidato? candidato;

    // Attempt to log in via the internet
    try {
      internetLoginSuccess = await login(_email.text, _senha.text);
      if (internetLoginSuccess) {
        candidato = await getData(_email.text, _senha.text);
      }
    } catch (e) {
      print('Error during internet login: $e');
    }

    if (!internetLoginSuccess) {
      // If internet login fails, attempt local login
      candidato = await attemptLocalLogin(_email.text, _senha.text);
      if (candidato == null) {
        // Show error if local storage login also fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dados incorrectos'),
            backgroundColor: Color.fromARGB(255, 235, 77, 3),
          ),
        );
      }
    }

    if (candidato != null) {
      // Navigate to home screen if login is successful
      Navigator.pushNamed(context, "/home", arguments: candidato);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            child: Image.asset('assets/images/ibe_moz.png'),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                label: Text("Email"),
                icon: Icon(Icons.mail, color: Colors.blue[900]),
                hintText: "Escreva o email",
                labelStyle: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: TextFormField(
              controller: _senha,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Senha"),
                icon: Icon(Icons.password, color: Colors.blue[900]),
                hintText: "Escreva a senha",
                labelStyle: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _handleLogin,
                        child: Text(
                          "Autenticar",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                        ),
                      ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/cadastro");
                  },
                  child: Text(
                    "Inscreva - se",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
