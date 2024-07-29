import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/views/abas_home/bolsas.dart';
import 'package:ibe_candidaturas/views/abas_home/candidaturas.dart';
import 'package:ibe_candidaturas/views/abas_home/documentos.dart';
import 'estado_candidatura.dart';
import 'abas_home/perfil.dart';
import 'bemvindo.dart';
import 'Notification.dart';

import 'package:ibe_candidaturas/controllers/candidatoController.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /* 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //login(senha, email)
  }
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IBE - Portal Candidatos',
        routes: {
          '/estado': (context) => EstadoCandidatura(),
        },
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              title: Text("IBE - Portal Candidatos",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Color.fromARGB(255, 46, 44, 190),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Novas Bolsas'),
                      content: const Text('Nenhuma bolsa lançada recentemente'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              iconTheme: IconThemeData(color: Colors.white),
              bottom: const TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 5.0,
                  dividerColor: Colors.white,
                  isScrollable: true,

                  //indicator: DecoratedBoxTransition(decoration: , child: child), SEARCH THE USE OF DECORATIOB
                  tabs: [
                    Tab(
                      icon: Icon(EvaIcons.home),
                      child: Text("Home"),
                    ),
                    Tab(
                      icon: Icon(EvaIcons.people),
                      child: Text("Perfil"),
                    ),
                    Tab(
                      icon: Icon(EvaIcons.listOutline),
                      child: Text("Bolsas"),
                    ),
                    Tab(icon: Icon(EvaIcons.list), child: Text("Candidaturas")),
                    Tab(icon: Icon(EvaIcons.file), child: Text("Documentos")),
                  ]),
            ),
            body: TabBarView(
              children: <Widget>[
                Bemvindo(),
                Perfil(),
                Bolsas(),
                Candidaturas(),
                Documentos(),
              ],
            ),
          ),
        ));
  }
}
