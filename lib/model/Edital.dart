class Edital {
  final int codedita;
  final int numero;
  final int ano;
  final String nome;
  String? imageUrl;

  Edital({
    required this.codedita,
    required this.ano,
    required this.numero,
    required this.nome,
     this.imageUrl, 
  });

  // Factory method to create an Edital instance from a JSON map
  factory Edital.fromJson(Map<String, dynamic> json) {
    return Edital(
      codedita: json['codEdital'],
      ano: json['ano'],
      numero: json['numero'],
      nome: json['nome'],
      imageUrl: json['imageUrl'],
      
    );
  }

  // Method to convert an Edital instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'codEdital': codedita,
      'ano': ano,
      'numero': numero,
      'nome': nome,
      'imageUrl': imageUrl
    };
  }
}
