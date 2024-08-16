import 'dart:convert';
import 'package:ibe_candidaturas/model/Candidatura.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';

class StorageUtils {


static Future<void> saveCandidato(Candidato candidato) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Convert Candidato to JSON string
  String candidatoJson = candidato.toJsonString();
  await prefs.setString('candidato', candidatoJson);
}


  static Future<Candidato?> loadCandidato() async {
    final prefs = await SharedPreferences.getInstance();
    // Get JSON string from SharedPreferences
    final candidatoJson = prefs.getString('candidato');
    if (candidatoJson != null) {
      // Convert JSON string to Map
      final candidatoMap = jsonDecode(candidatoJson) as Map<String, dynamic>;
      return Candidato.fromMap(candidatoMap);
    }
    return null;
  }


  static Future<void> saveCandidaturas(int codcandi, List<Candidatura> candidaturas) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(Candidatura.listToJson(candidaturas));
  await prefs.setString('candidaturas_$codcandi', jsonString);
}

static Future<List<Candidatura>> loadCandidaturas(int codcandi) async {
  SharedPreferences prefs = await SharedPreferences.getInstance().timeout(Duration(seconds: 10));
  String? jsonString = prefs.getString('candidaturas_$codcandi');
  
  // Verifique o valor do jsonString para depuração
  print('Dados carregados do SharedPreferences: $jsonString');
  
  if (jsonString != null && jsonString.isNotEmpty) {
    try {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return Candidatura.listFromJson(jsonList);
    } catch (e) {
      print('Erro ao decodificar JSON: $e');
    }
  }
  
  return [];
}


}
