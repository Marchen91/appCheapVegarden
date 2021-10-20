class Tarefa {
  String? id;
  String texto;
  int min;
  int max;
  double humidade;
  double temperatura;
  bool finalizada;

  Tarefa(
      {this.id,
      this.texto = '',
      this.finalizada = false,
      this.min = 0,
      this.max = 0,
      this.humidade = 0.0,
      this.temperatura = 0.0});

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'],
      texto: json['texto'],
      min: json['min'],
      max: json['max'],
      temperatura: json['temperatura'],
      humidade: json['humidade'],
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
      "humidade": humidade,
      "finalizada": finalizada
    };
  }
}
