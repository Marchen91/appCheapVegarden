class Irrigacao {
  DateTime? data;
  double? fluxo;
  double? volume;
  bool? solenoide;

  Irrigacao({
    this.data,
    this.fluxo = 0.0,
    this.volume = 0.0,
    this.solenoide = false,
  });

  Irrigacao.fromMap(Map<String, dynamic> map) {
    this.data = map['data'];
    this.fluxo = map['fluxo'];
    this.volume = map['volume'];
  }

  factory Irrigacao.fromJson(Map<String, dynamic> json) {
    return Irrigacao(
      data: json['data'],
      fluxo: json['fluxo'],
      volume: json['volume'],
      solenoide: json['solenoide'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data!,
      "fluxo": fluxo,
      "volume": volume,
      "solenoide": solenoide,
    };
  }
}
