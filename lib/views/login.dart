import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ibe_candidaturas/controllers/candidato.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  TextEditingController _senha = TextEditingController();
  TextEditingController _email = TextEditingController();

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
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Container(
              padding: EdgeInsets.all(50), // Adiciona padding ao Container
              child: Image.asset('assets/images/ibe_moz.png'),
            ),
          ),
          Text("Login",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900])),
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
              onPressed: () {
                login(_email, _senha);
                Navigator.pushNamed(context, "/home");
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
        ]));
  }
}
