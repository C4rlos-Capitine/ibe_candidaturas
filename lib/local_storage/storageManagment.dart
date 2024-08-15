import 'dart:convert';

import 'package:ibe_candidaturas/controllers/editalController.dart';
import 'package:ibe_candidaturas/model/Edital.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Edital>> loadEditaisFromLocal() async {
  List<Edital> editais = [];
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('editais');

    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      editais = jsonData.map((data) => Edital.fromJson(data)).toList();
    }
  } catch (e) {
    print('Error loading data from local storage: $e');
  }
  return editais;
}

Future<List<Edital>> fetchEditais() async {
  List<Edital> editais = await getEditais(); // Fetch from the server

  if (editais.isEmpty) {
    // If no data was fetched from the server, try loading from local storage
    editais = await loadEditaisFromLocal();
  }

  return editais;
}

