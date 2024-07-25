import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/views/abas_home/bolsas.dart';
import 'package:ibe_candidaturas/views/abas_home/candidaturas.dart';
import 'package:ibe_candidaturas/views/abas_home/documentos.dart';
import 'abas_home/perfil.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
          title: 'IBE - Portal Candidatos',
         
          home: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Bem Vindo", style: TextStyle(color: Colors.white)),
                backgroundColor: Color.fromARGB(255, 46, 44, 190),
              
                bottom: const TabBar(
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 5.0,dividerColor: Colors.white,
                    
                    //indicator: DecoratedBoxTransition(decoration: , child: child), SEARCH THE USE OF DECORATIOB
                    tabs: [
                      Tab(icon: Icon(Icons.people_alt), child: Text("Perfil"),),
                      Tab(icon: Icon(Icons.list_alt), child: Text("Bolsas"), ),
                      Tab(icon: Icon(Icons.list_alt), child: Text("Candidaturas")),
                      Tab(icon: Icon(Icons.list_alt), child: Text("Documentos")),
                    ]
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Perfil(),
                  Bolsas(),
                  Candidaturas(),
                  Documentos(),
                ],
              ),
            ),
          )
      );

    }
}
