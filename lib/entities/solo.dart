class Solo {
  double humidade;

  Solo({
    this.humidade = 0.0,
  });

  factory Solo.fromJson(Map<String, dynamic> json) {
    return Solo(
      humidade: json['humidade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "humidade": humidade,
    };
  }
}
