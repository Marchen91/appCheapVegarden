class Tarefa {
  String? id;
  String texto;
  int min;
  int max;
  double umidade;
  double umidadeSolo;
  double temperatura;
  bool finalizada;

  Tarefa(
      {this.id,
      this.texto = '',
      this.finalizada = false,
      this.min = 0,
      this.max = 0,
      this.umidade = 0.0,
      this.umidadeSolo = 0.0,
      this.temperatura = 0.0});

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'],
      texto: json['texto'],
      min: json['min'],
      max: json['max'],
      temperatura: json['temperatura'],
      umidade: json['umidade'],
      umidadeSolo: json['umidadeSolo'],
      finalizada: json['finalizada'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id!,
      "texto": texto,
      "min": min,
      "max": max,
      "temperatura": temperatura,
      "umidade": umidade,
      "umidadeSolo": umidadeSolo,
      "finalizada": finalizada
    };
  }
}
