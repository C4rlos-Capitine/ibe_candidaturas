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
    codcandi: json['codcandi'] != null ? json['codcandi'] as int : 0,
    cod_edital: json['cod_edital'] != null ? json['cod_edital'] as int : 0,
    codecurso: json['codecurso'] != null ? json['codecurso'] as int : 0,
    estado: json['estado'] != null ? json['estado'] as String : '',
    resultado: json['resultado'] != null ? json['resultado'] as String : '',
    curso: json['curso'] != null ? json['curso'] as String : '',
    edital: json['edital'] != null ? json['edital'] as String : '',
    data_submissao: json['data_subm'] != null ? json['data_subm'] as String : '',
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
      'data_subm': data_submissao, // Adjust field name for consistency with API
      'resultado': resultado,
    };
  }
}
