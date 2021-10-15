import 'package:tarefas_app/entities/tarefa.dart';

class TarefaMemoryRepository {
  // atributo
  List<Tarefa> tarefas = [];

  // construtor
  TarefaMemoryRepository() {
    // tarefas = [];
    // tarefas
    //     .add(Tarefa(id: 1, texto: 'Passear com o cachorro', finalizada: false));
    // tarefas.add(Tarefa(id: 2, texto: 'Estudar para prova', finalizada: false));
    // tarefas.add(Tarefa(id: 3, texto: 'Fazer a matrícula', finalizada: true));
  }

  // métodos:
  void create(Tarefa entity) {
    tarefas.add(entity);
  }

  List<Tarefa> read() {
    return tarefas;
  }

  void update(
      String id, String valueTexto, bool value, int valueMin, int valueMax) {
    var index = tarefas.indexWhere((tarefa) => tarefa.id == id);
    tarefas[index].finalizada = value;
    tarefas[index].texto = valueTexto;
    tarefas[index].min = valueMin;
    tarefas[index].max = valueMax;
  }

  void delete(Tarefa entity) {
    tarefas.remove(entity);
  }
}
