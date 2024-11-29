import 'dart:convert'; // For Base64 decoding
import 'dart:typed_data'; // For Uint8List (image bytes)
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/controllers/editalController.dart';
import 'package:ibe_candidaturas/model/Edital.dart';

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
      body: Stack(
        children: [
          // The body content inside a ListView.builder
          _edital == null
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
                        subtitle: Text(
                            'Ano: ${edital.ano}, Vagas: ${edital.numero}'),
                        leading: edital.imageUrl != null
                            ? _buildImage(edital.imageUrl!) // Display the image from imageUrl
                            : Icon(Icons.image, color: Colors.blue[900]), // Placeholder if no image
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Faça o auto - registo na aba de inscrições para se candidatar',
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 229, 231, 91),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

          // Fixed Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,  // Customize the color of the bar
              height: 20.0,             // Customize the height of the bar
              child: Center(
                child: Text(
                  'Copyright © 2024 | Quidgest',
                  style: TextStyle(color: Colors.blue[900]),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the image from either URL or Base64
  Widget _buildImage(String imageUrl) {
    try {
      // Check if the imageUrl is a valid Base64 string
      if (imageUrl.startsWith('data:image')) {
        // It's a Base64 string
        Uint8List bytes = base64Decode(imageUrl.split(',').last); // Extract the Base64 content
        return Image.memory(
          bytes,
          width: 25, // Set the width as needed
          height: 25, // Set the height as needed
          fit: BoxFit.cover,
        );
      } else {
        // It's a URL
        return Image.network(
          imageUrl,
          width: 25, // Set the width as needed
          height: 25, // Set the height as needed
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      // If there's an error in decoding Base64 or loading the image, show an error icon
      return Icon(Icons.error, color: Colors.red);
    }
  }
}
