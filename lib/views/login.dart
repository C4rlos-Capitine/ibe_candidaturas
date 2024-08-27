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
import 'package:iconsax/iconsax.dart';

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

            margin: EdgeInsets.symmetric(vertical: 25, horizontal: 70),
            child: Image.asset('assets/images/ibe_moz.png'),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
          
            child: Card(
              elevation: 4.0,
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.info_circle5, color: Colors.blue[900],),
                    Text(
                      "Bem vindo ao portal, introduza o email e a senha para ter acesso ao seus dados e das suas candidaturas, ou inscreva - se na aba de Inscrição",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue[900], 
                      ),
                      textAlign: TextAlign.justify,
                      
                    ),
                  ],
                ),
              ),
            )
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
