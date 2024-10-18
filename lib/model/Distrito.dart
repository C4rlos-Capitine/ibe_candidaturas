class Distrito {
  final int coddistrito;
  final String nome;

  Distrito({
    required this.coddistrito,
    required this.nome,
  });

  // Factory method to create a Distrito instance from a JSON map
  factory Distrito.fromJson(Map<String, dynamic> json) {
    return Distrito(
      coddistrito: json['coddistrito'],
      nome: json['nome'],
    );
  }

  // Method to convert a Distrito instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'coddistrito': coddistrito,
      'nome': nome,
    };
  }
}
