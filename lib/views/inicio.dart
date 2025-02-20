import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/views/abas_inicio/cadastrar_dio.dart';
import 'package:ibe_candidaturas/views/abas_inicio/login.dart';
import 'package:ibe_candidaturas/views/abas_home/bolsas_2.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:iconsax/iconsax.dart';

//import 'package:ibe_candidaturas/sqlite_connection/CRUD_Candidatos.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  Candidato? _candidato;
  bool? connectado;
  late Future<NetworkCheckResponse> _networkCheckResponse;
  @override
  void initState() {
    //_addCandidato();
    //_loadCandidatos();
    var _networkCheckResponse = isConnected();
    print(_networkCheckResponse);
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  _checkNetworkStatus();
  
  }
  Future<void> _checkNetworkStatus() async {
    NetworkCheckResponse response = await isConnected();
    print('msg: ${response.mesg}');
    print('status: ${response.state}');
  }

  

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [],
       // toolbarHeight: *100/,
        title: Text(
          "IBE,IP Candidaturas",
          style:
              TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        // backgroundColor: Colors.blue[900],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue[900],
          indicatorColor: Colors.blue[900],
          tabAlignment:TabAlignment.fill,
          
          tabs: [

            Tab(
              icon: Icon(Iconsax.home_1, color: Colors.blue[900]),
              child: Text("Login", style: TextStyle(fontSize: 13),),
            ),
            /*Tab(
              icon: Icon(
                Iconsax.info_circle,
                color: Colors.blue[900],
              ),
              child: Text("Sobre nós", style: TextStyle(fontSize: 13),),
            ),*/
            Tab(
              icon: Icon(
                EvaIcons.listOutline,
                color: Colors.blue[900],
              ),
              child: Text("Bolsas", style: TextStyle(fontSize: 13)),
            ),
            Tab(
              icon: Icon(
                Iconsax.profile_add4,
                color: Colors.blue[900],
              ),
              child: Text("Candidatar - se", style: TextStyle(fontSize: 11),),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          //Bemvindo(),
          Login(),
         // SobreNos(), // Replace with your actual widget
          Bolsas(),
          //Cadastro()
          CadastrarDio()
        ],
      ),
    );
  }
}
