import 'package:flutter/material.dart';
import 'dart:convert';

class Mensagens {
  final int id;
  final String msg;
  final String title;
  final String email;
  final int lida;
  final int codedital; // Added missing field
  final String data_envio;
  final String edital;

  // Construtor
  Mensagens({
    required this.id,
    required this.msg,
    required this.title,
    required this.email,
    required this.lida,
    required this.codedital, // Added missing field
    required this.data_envio,
    required this.edital,
  });

  // Método para converter de Map para Mensagens
  factory Mensagens.fromMap(Map<String, dynamic> map) {
    return Mensagens(
      id: map['id'],
      msg: map['msg'],
      title: map['title'],
      email: map['email'],
      lida: map['lida'],
      codedital: map['codedital'], // Added missing field
      data_envio: map['data_envio'],
      edital: map['edital'],
    );
  }

  // Método para converter de Mensagens para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'msg': msg,
      'title': title,
      'email': email,
      'lida': lida,
      'codedital': codedital, // Added missing field
      'data_envio': data_envio,
      'edital': edital,
    };
  }

  // Método para converter de Mensagens para JSON
  String toJson() => json.encode(toMap());

  // Método para converter de JSON para Mensagens
  factory Mensagens.fromJson(String source) => Mensagens.fromMap(json.decode(source));
}
