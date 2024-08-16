import 'dart:convert';

class Candidatura {
  late int cod_edital;
  late int codecurso;
  late int codcandi;
  late String curso;
  late String edital;
  late String estado;
  late String resultado;
  late String data_submissao;

  Candidatura({
    required this.cod_edital,
    required this.codecurso,
    required this.codcandi,
    required this.curso,
    required this.edital,
    required this.estado,
    required this.data_submissao,
    required this.resultado,
  });

  factory Candidatura.fromJson(Map<String, dynamic> json) {
    return Candidatura(
      codcandi: json['codcandi'] ?? 0,
      cod_edital: json['cod_edital'] ?? 0,
      codecurso: json['codecurso'] ?? 0,
      estado: json['estado'] ?? '',
      resultado: json['resultado'] ?? '',
      curso: json['curso'] ?? '',
      edital: json['edital'] ?? '',
      data_submissao: json['data_subm'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod_edital': cod_edital,
      'codecurso': codecurso,
      'codcandi': codcandi,
      'curso': curso,
      'edital': edital,
      'estado': estado,
      'data_subm': data_submissao,
      'resultado': resultado,
    };
  }

  static List<Candidatura> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Candidatura.fromJson(json)).toList();
  }

  static List<dynamic> listToJson(List<Candidatura> candidaturaList) {
    return candidaturaList.map((candidatura) => candidatura.toJson()).toList();
  }
}
