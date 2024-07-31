import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ibe_candidaturas/views/abas_home/bolsas.dart';
import 'package:ibe_candidaturas/views/abas_home/candidaturas.dart';
import 'package:ibe_candidaturas/views/abas_home/documentos.dart';
import 'estado_candidatura.dart';
import 'abas_home/perfil.dart';
import 'bemvindo.dart';
import 'Notification.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';


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
      title: 'IBE - Portal Candidatos',
      routes: {
        '/estado': (context) => EstadoCandidatura(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "IBE - Portal Candidatos",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
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
          iconTheme: IconThemeData(color: Colors.blue[900]),
        ),
        body: _widgetOptions.isNotEmpty
            ? _widgetOptions.elementAt(_selectedIndex)
            : Center(child: Text('No content available')), // Default widget
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(EvaIcons.home, color: Color.fromARGB(255, 2, 33, 232)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(EvaIcons.person, color: Color.fromARGB(255, 2, 33, 232)),
              label: 'Perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(EvaIcons.listOutline, color: Color.fromARGB(255, 2, 33, 232)),
              label: 'Bolsas',
            ),
            BottomNavigationBarItem(
              icon: Icon(EvaIcons.list, color: Color.fromARGB(255, 2, 33, 232)),
              label: 'Candidaturas',
            ),
            BottomNavigationBarItem(
              icon: Icon(EvaIcons.file, color: Color.fromARGB(255, 2, 33, 232)),
              label: 'Documentos',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[900],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  List<Widget> get _widgetOptions {
    if (_candidato == null) {
      return []; // Return an empty list if candidato is not yet initialized
    }
    return [
      Bemvindo(),
      Perfil(candidato: _candidato!),
      Bolsas(),
      Candidaturas(candidato: _candidato!),
      Documentos(candidato: _candidato!),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
