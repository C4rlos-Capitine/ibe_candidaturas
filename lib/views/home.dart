import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ibe_candidaturas/views/abas_home/bolsas.dart';
import 'package:ibe_candidaturas/views/abas_home/candidaturas.dart';
import 'package:ibe_candidaturas/views/abas_home/documento2.dart';
import 'package:ibe_candidaturas/views/abas_home/documentos.dart';
import 'package:ibe_candidaturas/views/abas_home/perfil.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';
import 'package:ibe_candidaturas/views/help_center.dart';
import 'package:ibe_candidaturas/views/inicio.dart';
import 'package:ibe_candidaturas/views/notificacoes.dart';
import 'package:ibe_candidaturas/views/settings.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:iconsax/iconsax.dart';

enum Menu { settings, about_app, help, logout }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Candidato? _candidato;
  bool _isCandidatoInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final candidato = ModalRoute.of(context)!.settings.arguments as Candidato;
      print("candi $candidato");
      setState(() {
        _candidato = candidato;
        _isCandidatoInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCandidatoInitialized || _candidato == null) {
      return MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IBE,IP - Portal do Candidatos',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 34, 88, 236),
          actions: <Widget>[
            PopupMenuButton<Menu>(
              color: Colors.white,
              icon: Icon(Icons.more_vert, color: Colors.white),
              onSelected: (Menu item) {
                switch (item) {
                  case Menu.settings:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings()),
                    );
                    break;
                  case Menu.about_app:
                    // Handle About App action
                    break;
                  case Menu.help:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Help_center()),
                    );
                    break;
                  case Menu.logout:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inicio()),
                    );
                    //Navigator.pushNamed(context, "/inicio");
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem<Menu>(
                  value: Menu.settings,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Definições'),
                  ),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.about_app,
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Sobre o aplicativo'),
                  ),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.help,
                  child: ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Suporte'),
                  ),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.logout,
                  child: ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text('Saír'),
                  ),
                ),
              ],
            ),
          ],
          iconTheme: IconThemeData(color: Colors.blue[900]),
        ),
        body: _widgetOptions.isNotEmpty
            ? _widgetOptions.elementAt(_selectedIndex)
            : Center(child: Text('No content available')),
        bottomNavigationBar: NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.notification, color: Color.fromARGB(255, 34, 88, 236)),
              label: 'Notificações',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.profile_2user4, color: Color.fromARGB(255, 34, 88, 236)),
              label: 'Perfil',
            ),
            NavigationDestination(
              icon: Icon(EvaIcons.plus, color: Color.fromARGB(255, 34, 88, 236)),
              label: 'Bolsas',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.information, color: Color.fromARGB(255, 34, 88, 236)),
              label: 'Candidatura',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.document_1, color: Color.fromARGB(255, 34, 88, 236)),
              label: 'Documentos',
            ),
          ],
          //selectedItemColor: Colors.blue[900],
        ),
      ),
    );
  }

  List<Widget> get _widgetOptions {
    if (_candidato == null) {
      return []; // Return an empty list if candidato is not yet initialized
    }
    return [
      Notificacoes(candidato: _candidato!),
      Perfil(candidato: _candidato!),
      Bolsas(candidato: _candidato!),
      EstadoCandidatura(candidato: _candidato!),
      Documento2(candidato: _candidato!),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
