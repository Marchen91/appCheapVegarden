class Estufa {
  //String? id;
  double humidade;
  double temperatura;

  Estufa({this.humidade = 0.0, this.temperatura = 0.0});

  factory Estufa.fromJson(Map<String, dynamic> json) {
    return Estufa(
      temperatura: json['temperatura'],
      humidade: json['humidade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "temperatura": temperatura,
      "humidade": humidade,
    };
  }
}
