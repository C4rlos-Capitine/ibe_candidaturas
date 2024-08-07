import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/views/cadastrar2.dart';
import 'package:ibe_candidaturas/views/login.dart';
import 'package:ibe_candidaturas/views/abas_home/bolsas_2.dart';
import 'package:ibe_candidaturas/views/bemvindo.dart';
import 'package:ibe_candidaturas/views/sobre.dart';
import 'package:ibe_candidaturas/sqlite_connection/CRUD_Candidatos.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Candidato? _candidato;
  @override
  void initState() {
    //_addCandidato();
    //_loadCandidatos();
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }


  Future<void> _addCandidato() async {
    await DatabaseHelper.insertCandidato({
      'id': null,
      'nome': 'John Doe',
      'apelido': 'Doe',
      'email': 'john.doe@example.com',
      'senha': '1234',
      'telefone': '123456789',
      'telemovel': '987654321',
      'genero': 'M',
      'dia': 1,
      'mes': 1,
      'ano': 1990,
      'codprovi': 1,
    });
    //_loadCandidatos();
  }

  Future<void> _loadCandidatos() async {
    final sqlite_candidatos = await DatabaseHelper.getCandidatos();
    print(sqlite_candidatos);
    setState(() {
      //Cand_ = candidatos;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        actions: [],
        title: Text(
          "IBE - Portal do Candidato",
          style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        iconTheme: IconThemeData(color: Colors.white),
       // backgroundColor: Colors.blue[900],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue[900],
          indicatorColor: Colors.blue[900],
          isScrollable: true,
         // padding: EdgeInsetsGeometry.infinity,
          tabs: [
            Tab(
              icon: Icon(EvaIcons.home, color: Colors.blue[900],),
              child: Text("Bem vindo"),
            ),
            Tab(
              icon: Icon(EvaIcons.logIn, color: Colors.blue[900]),
              child: Text("Login"),
            ),
            Tab(
              icon: Icon(EvaIcons.info, color: Colors.blue[900],),
              child: Text("Sobre nós"),
            ),
            Tab(
              icon: Icon(EvaIcons.list, color: Colors.blue[900],),
              child: Text("Bolsas"),
            ),
            Tab(
              icon: Icon(EvaIcons.personAdd, color: Colors.blue[900],),
              child: Text("Inscrição"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,

        children: [
          Bemvindo(),
          Login(),
          SobreNos(), // Replace with your actual widget
          Bolsas(),
          Cadastro()
        ],
      ),
    );
  }
}
