import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ibe_candidaturas/controllers/notification_controller.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/model/Mensagens.dart';

class Notificacoes extends StatefulWidget {
  const Notificacoes({super.key, required this.candidato});
  final Candidato candidato;

  @override
  State<Notificacoes> createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  List<Mensagens>? _mensagens;

  Future<void> _loadMsgs() async {
    try {
      List<Mensagens> mesg = await NotificationController.getMesg(widget.candidato.email);
      setState(() {
        _mensagens = mesg; // Update the state with the fetched data
      });
      NotificationController.marcarLida(widget.candidato.email);
    } catch (e) {
      print('Error loading messages: $e');
      Fluttertoast.showToast(
        msg: "Failed to load messages. Showing cached data.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      // Optionally, you can still use cached data here if needed
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMsgs(); // Load messages when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _mensagens == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _mensagens!.length,
              itemBuilder: (context, index) {
                final mensagem = _mensagens![index]; // Use a descriptive variable name
                return Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(mensagem.title), // Access title correctly
                    subtitle: Text('Mensagem: ${mensagem.msg}'), // Access msg correctly
                    onTap: () {
                    },
                    leading: Image.asset(
                      'assets/images/icon.png', // Replace with your image URL
                      width: 20, // Set your desired width
                      height: 20, // Set your desired height
                    ),
                  ),
                );
              },
            ),
    );
  }
}
