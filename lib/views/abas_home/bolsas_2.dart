import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/controllers/editalController.dart';
import 'package:ibe_candidaturas/model/Edital.dart';
import 'package:ibe_candidaturas/views/estado_candidatura.dart';
import 'package:ibe_candidaturas/views/nova_candidatura.dart';

class Bolsas extends StatefulWidget {
  const Bolsas({super.key});

  @override
  State<Bolsas> createState() => _BolsasState();
}

class _BolsasState extends State<Bolsas> {
  List<Edital>? _edital;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Check network status and wait for the result
    _connected = await _checkNetworkStatus();
    print("after check: $_connected");
    await _loadEditais();
    /*if (_connected) {
      // Load data if connected
      await _loadEditais();
    } else {
      // Show a snack bar if not connected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verifique se o wifi ou dados estão ligados'),
          backgroundColor: Color.fromARGB(255, 235, 77, 3),
        ),
      );
      setState(() {
        _edital = null; // Clear or handle data if not connected
      });
    }*/
  }

  Future<bool> _checkNetworkStatus() async {
    try {
      final response = await isConnected();
      print('Network Status: ${response.state}');
      print('Message: ${response.mesg}');
      return response.state;
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  Future<void> _loadEditais() async {
    try {
      List<Edital> editais = await fetchEditais(); // Use fetchEditais to handle both server and local data
      setState(() {
        _edital = editais; // Update the state with the fetched data
      });
    } catch (e) {
      print('Error loading editais: $e');
      Fluttertoast.showToast(
        msg: "Failed to load editais. Showing cached data.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      // Optionally, you can still use cached data here if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Novos editais de bolsas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 3, 55, 226),
            backgroundColor: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: _edital == null
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
                    subtitle: Text('Ano: ${edital.ano}, Número: ${edital.numero}'),
                    //leading: Icon(Icons.download, color: Colors.blue[900],),
                    leading: Image.network(
                      'http://localhost:5287/api/Images/paises/${edital.codedita}', // Replace with your image URL
                      width: 40, // Set your desired width
                      height: 40, // Set your desired height
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Faça o auto - registo na aba de inscrições para se candidatar', style: TextStyle(color: Colors.blue[900]),),
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
