class Posto {
  final int codposto;
  final String nome;

  Posto({
    required this.codposto,
    required this.nome,
  });

  // Factory method to create a Posto instance from a JSON map
  factory Posto.fromJson(Map<String, dynamic> json) {
    return Posto(
      codposto: json['codposto'],
      nome: json['nome'],
    );
  }

  // Method to convert a Posto instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'codposto': codposto,
      'nome': nome,
    };
  }
}
