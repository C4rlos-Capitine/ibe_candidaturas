import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/controllers/editalController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/model/Edital.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';
import 'package:ibe_candidaturas/views/nova_candidatura.dart';

class Bolsas extends StatefulWidget {
  final Candidato candidato;

  const Bolsas({super.key, required this.candidato});

  @override
  State<Bolsas> createState() => _BolsasState();
}

class _BolsasState extends State<Bolsas> {
  List <Edital>? _edital;
  
  @override
  void initState() {
    super.initState();
    print(widget.candidato.codigo);
    _loadEditais(); // Call the async method to load data
  }

  // Asynchronous method to load data
  Future<void> _loadEditais() async {
    try {
      List<Edital> editais = await getEditais();
      setState(() {
        _edital = editais; // Update the state with the fetched data
      });
    } catch (e) {
      // Handle errors here
      print('Error loading editais: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Novos editais de bolsas", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 55, 226),fontSize: 16)),
      ),
      body:  _edital == null 
      ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _edital!.length,
              itemBuilder: (context, index) {
                final edital = _edital![index];
                return Card(
                  color: Colors.white,
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(edital.nome),
                    subtitle:
                        Text('Ano: ${edital.ano}, Número: ${edital.numero}'),
                    //leading: Icon(Icons.download, color: Colors.blue[900],),
                    leading: Image.network(
                      'http://$IP/api/Images/paises/${edital.codedita}', // Replace with your image URL
                      width: 20, // Set your desired width
                      height: 20, // Set your desired height
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Faça o auto - registo na aba de inscrições para se candidatar',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                          backgroundColor: Color.fromARGB(255, 229, 231, 91),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}