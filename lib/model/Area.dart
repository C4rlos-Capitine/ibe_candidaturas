class Area{
  final int codarea;
  final int codedita;
  final String nome;

  Area({required this.codarea, required this.codedita, required this.nome});
    factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      codedita: json['codedita'],
      codarea: json['codarea'],
      nome: json['nome']
    );
  }

  // Method to convert an Edital instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'codedita': codedita,
      'codarea': codarea,
      'nome': nome,
    };
  }
}