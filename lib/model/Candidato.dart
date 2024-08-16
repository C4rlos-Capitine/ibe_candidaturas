import 'dart:convert';

class Candidato {
  late String nome;
  late String apelido;
  late String telemovel;
  late String telefone;
  late String email;
  late int codigo;
  late bool isEmpty;
  late int idade;
  late int identificacao;
  late String naturalidade;

  Candidato({
    required this.nome,
    required this.apelido,
    required this.codigo,
    required this.telefone,
    required this.telemovel,
    required this.email,
    required this.isEmpty,
    required this.idade,
    required this.identificacao,
    required this.naturalidade,
  });

  factory Candidato.fromMap(Map<String, dynamic> map) {
    return Candidato(
      nome: map['nome'] ?? '',
      apelido: map['apelido'] ?? '',
      codigo: map['codcandi'] ?? 0,
      telefone: map['telefone'] ?? '',
      telemovel: map['telemovel'] ?? '',
      email: map['email'] ?? '',
      isEmpty: map['isEmpty'] ?? true,
      idade: map['idade'] ?? 0,
      identificacao: map['num_ident'] ?? 0,
      naturalidade: map['naturalidade'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'apelido': apelido,
      'codcandi': codigo,
      'telefone': telefone,
      'telemovel': telemovel,
      'email': email,
      'isEmpty': isEmpty,
      'idade': idade,
      'num_ident': identificacao,
      'naturalidade': naturalidade,
    };
  }


  
  String toJsonString() {
    // Convert Candidato to JSON string
    return jsonEncode(toJson());
  }
  
}
