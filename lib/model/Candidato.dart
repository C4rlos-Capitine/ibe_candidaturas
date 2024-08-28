import 'dart:convert';

class Candidato {
  late String nome;
  late String apelido;
  late String nomecomp;
  late String telemovel;
  late String telefone;
  late String email;
  late int codigo;
  late bool findTrue;
  late int idade;
  late String identificacao;
  late String naturalidade;
  late String datadena;
  late String data_emissao;
  late String data_validade;
  var genero;
  late String provincia;
  late int codprovi;
  late String rua;
  late String ocupacao;
  late String edital;
  late String area;
  late String especialidade;
  late String estado;
  late String nivel;
  late int pontuacao;

  Candidato({
    required this.nome,
    required this.apelido,
    required this.nomecomp,
    required this.codigo,
    required this.telefone,
    required this.telemovel,
    required this.email,
    required this.findTrue,
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
    required this.ocupacao,
    required this.edital,
    required this.area,
    required this.especialidade,
    required this.estado,
    required this.nivel,
    required this.pontuacao
  });

  factory Candidato.fromMap(Map<String, dynamic> map) {
    return Candidato(
      nome: map['nome'] ?? '',
      apelido: map['apelido'] ?? '',
      nomecomp: map['nomecomp'] ?? '',
      codigo: map['codcandi'] ?? 0,
      telefone: map['telefone'] ?? '',
      telemovel: map['telemovel'] ?? '',
      email: map['email'] ?? '',
      findTrue: map['findTrue'] ?? true,
      idade: map['idade'] ?? 0,
      identificacao: map['identificacao'] ?? '',
      naturalidade: map['naturalidade'] ?? '',
      datadena: map['datadena'] ?? '',
      data_emissao: map['data_emissao'] ?? '',
      data_validade: map['data_validade'] ?? '',
      genero: map['genero'] ?? '',
      provincia: map['provincia'] ?? '',
      codprovi: map['codprovi'] ?? 0,
      rua: map['rua'] ?? '',
      ocupacao: map['ocupacao'] ?? '', 
      edital: '', 
      area: '',
      especialidade: '',
      estado: '', nivel: '', pontuacao: 0
    );
  }
  


  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'apelido': apelido,
      'nomecomp': nomecomp,
      'codcandi': codigo,
      'telefone': telefone,
      'telemovel': telemovel,
      'email': email,
      'findTrue': findTrue,
      'idade': idade,
      'identificacao': identificacao,
      'naturalidade': naturalidade,
      'datadena': datadena,
      'data_emissao': data_emissao,
      'data_validade': data_validade,
      'genero': genero,
      'provincia': provincia,
      'codprovi': codprovi,
      'rua': rua,
      'ocupacao': ocupacao,
      'edital': edital,
      'area': area,
      'especialidade': especialidade,
      'estado': estado,
      'nivel':nivel,
      'pontuacao': pontuacao
    };
  }


  
  String toJsonString() {
    // Convert Candidato to JSON string
    return jsonEncode(toJson());
  }
  
}
