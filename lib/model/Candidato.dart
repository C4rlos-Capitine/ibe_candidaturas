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
  late String datadena;
  late String data_emissao;
  late String data_validade;
  var genero;
  late String provincia;
  late int codprovi;
  late String rua;
  late String ocupacao;

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
    required this.datadena,
    required this.data_emissao,
    required this.data_validade,
    required this.genero,
    required this.provincia,
    required this.codprovi,
    required this.rua,
    required this.ocupacao
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
      datadena: map['datadena'] ?? '',
      data_emissao: map['data_emissao'],
      data_validade: map['data_validade'],
      genero: map['genero'],
      provincia: map['provincia'],
      codprovi: map['codprovi'],
      rua: map['rua'],
      ocupacao: map['ocupacao']
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
      'datadena': datadena,
      'data_emissao': data_emissao,
      'data_validade': data_validade,
      'genero': genero,
      'provincia': provincia,
      'codprovi': codprovi,
      'rua': rua,
      'ocupacao': ocupacao 
    };
  }


  
  String toJsonString() {
    // Convert Candidato to JSON string
    return jsonEncode(toJson());
  }
  
}
