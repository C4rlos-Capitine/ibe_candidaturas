import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Bolsas extends StatefulWidget {
  const Bolsas({super.key});

  @override
  State<Bolsas> createState() => _BolsasState();
}

class _BolsasState extends State<Bolsas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2023"),
                onTap: () {
                  /*Fluttertoast.showToast(
                    msg: "Edital Baizado com Sucesso",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 3, 235, 34),
                    textColor: Colors.white,
                    fontSize: 16.0
                );*/
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2024 (clique aqui para baixar editar)"),
                onTap: () {
                  
                },
              ),
              
            ),
             Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2023 (clique aqui para baixar editar)"),
                onTap: () {
                  
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2024 (clique aqui para baixar editar)"),
                onTap: () {
                  
                },
              ),
              
            ), Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2023 (clique aqui para baixar editar)"),
                onTap: () {
                  
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2024 (clique aqui para baixar editar)"),
                onTap: () {
                  
                },
              ),
              
            ),
             Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2023 (clique aqui para baixar editar)"),
                onTap: () {
                  
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Bolsa para China"),
                subtitle: Text("Edital: AAAA/2024 (clique aqui para baixar editar)"),
                onTap: () {
                  
                },
              ),
              
            )
          ],
        ),
      )
    );
  }
}