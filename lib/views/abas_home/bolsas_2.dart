import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  @override
  void initState() {
    super.initState();
    _loadEditais(); // Call the async method to load data
  }

  // Asynchronous method to load data
  Future<void> _loadEditais() async {
    try {
      List<Edital> editais = await fetchEditais(); // Use fetchEditais to handle both server and local data
      setState(() {
        _edital = editais; // Update the state with the fetched data
      });
    } catch (e) {
      // Handle errors here
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
        title: Text(
          "Novos editais de bolsas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 3, 55, 226),
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
                  child: ListTile(
                    title: Text(edital.nome),
                    subtitle: Text('Ano: ${edital.ano}, Número: ${edital.numero}'),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Faça o auto - registo na aba de inscrições para se candidatar'),
                          backgroundColor: Color.fromARGB(255, 235, 77, 3),
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
