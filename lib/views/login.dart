import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text("IBE"),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue[900],
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Container(
              padding: EdgeInsets.all(15.0), // Adiciona padding ao Container
              child: Image.asset('assets/images/ibe_moz.png'),
            ),
          ),
          Card(
            child: Text("Login"),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(50),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                  icon: Icon(Icons.mail)),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(50),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Senha"),
                  icon: Icon(Icons.password)),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/main_screen");
              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[900],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cadastro");
              },
              child: Text("Inscrever - se"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[900],
              ),
            ),
          ),
        ]));
  }
}
