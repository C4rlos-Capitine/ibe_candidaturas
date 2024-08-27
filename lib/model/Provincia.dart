class Provincia{
  late int codprovi;
  late String provinc;

  Provincia({
    required this.codprovi,
    required this.provinc
  });

  factory Provincia.fromJson(Map<String, dynamic> json){
    return Provincia(codprovi: json["codprovi"], provinc: json["provinc"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'codprovi': codprovi,
      'provinc': provinc,
    };
  }
}
