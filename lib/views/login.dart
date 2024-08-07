import 'package:flutter/material.dart';
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
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Container(
            //padding: EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.all(40), // Adiciona padding ao Container
              child: Image.asset('assets/images/ibe_moz.png'),
            ),
          ),
          Text("Login",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900])
                ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Email"),
                icon: Icon(Icons.mail, color: Colors.blue[900]),
                hintText: "Escreva o email",
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
                border: OutlineInputBorder(),
                label: Text("Senha"),
                icon: Icon(Icons.password, color: Colors.blue[900]),
                hintText: "Escreva a senha",
                //labelText: "Senha"
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
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
          ),
          SizedBox(height: 10),
          Container(
            child: ElevatedButton(
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
          ),
        ]),
    );
  }
}
