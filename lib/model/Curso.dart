class Curso{
  late final int codcurso;
  late final String nome;

  Curso({
    required this.codcurso,
    required this.nome,
  });

  factory Curso.fromJson(Map<String, dynamic> json){
    return Curso(codcurso: json["codcurso"], nome: json["nome"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'codcurso': codcurso,
      'nome': nome,
    };
  }
}