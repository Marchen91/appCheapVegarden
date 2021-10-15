class Tarefa {
  String? id;
  String texto;
  int min;
  int max;
  bool finalizada;

  Tarefa(
      {this.id,
      this.texto = '',
      this.finalizada = false,
      this.min = 0,
      this.max = 0});

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'],
      texto: json['texto'],
      min: json['min'],
      max: json['max'],
      finalizada: json['finalizada'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id!,
      "texto": texto,
      "min": min,
      "max": max,
      "finalizada": finalizada
    };
  }
}
