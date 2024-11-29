import 'dart:convert'; // Para converter Base64 para imagem
import 'dart:typed_data'; // Para trabalhar com dados binários
import 'package:flutter/material.dart'; 
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/controllers/editalController.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:ibe_candidaturas/model/Edital.dart';
import 'package:ibe_candidaturas/views/nova_candidatura.dart';

class Bolsas extends StatefulWidget {
  final Candidato candidato;

  const Bolsas({super.key, required this.candidato});

  @override
  State<Bolsas> createState() => _BolsasState();
}

class _BolsasState extends State<Bolsas> {
  List<Edital>? _edital;

  @override
  void initState() {
    super.initState();
    print(widget.candidato.codigo);
    _loadEditais(); // Chama o método assíncrono para carregar os dados
  }

  // Método assíncrono para carregar os dados
  Future<void> _loadEditais() async {
    try {
      List<Edital> editais = await getEditais();
      setState(() {
        _edital = editais; // Atualiza o estado com os dados carregados
      });
    } catch (e) {
      // Trata erros aqui
      print('Erro ao carregar editais: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Novos editais de bolsas", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 55, 226), fontSize: 16)),
      ),
      body: _edital == null
          ? const Center(child: CircularProgressIndicator()) // Exibe o indicador de carregamento enquanto os dados estão sendo buscados
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
                    leading: edital.imageUrl != null
                        ? _buildImage(edital.imageUrl!) // Construa a imagem a partir da URL base64
                        : Icon(Icons.image, color: Colors.blue[900]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NovaCandidatura(
                            codedita: edital.codedita,
                            ano: edital.ano,
                            numero: edital.numero,
                            nome: edital.nome,
                            candidato: widget.candidato,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  // Função para construir a imagem a partir da string Base64
  Widget _buildImage(String base64Image) {
    try {
      // Decodifica a imagem Base64 para bytes
      Uint8List bytes = base64Decode(base64Image);

      return Image.memory(
        bytes,
        width: 25, // Defina a largura desejada
        height: 25, // Defina a altura desejada
        fit: BoxFit.cover, // Ajuste o formato da imagem
      );
    } catch (e) {
      // Se ocorrer um erro ao decodificar a imagem, exibe um ícone de erro
      return Icon(Icons.error, color: Colors.red);
    }
  }
}
