import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/entities/tarefa.dart';
import 'package:tarefas_app/services/tarefa.service.dart';

class ListaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "CHEAPVEGARDEN",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Color.fromRGBO(142, 215, 206, 10),
      ),
      body: Column(children: [
        //Padding(padding: ),
        SizedBox(height: 30),
        Text(
          "Culturas",
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: 'Homegarden'),
        ),
        SizedBox(height: 30),
        Flexible(
          child: Consumer<TarefaService>(
            builder: (context, service, child) {
              var lista = service.tarefas;
              if (lista.isEmpty) {
                return Center(
                    child: Text(
                  "Nenhuma cultura cadastrada",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ));
              }

              return ListView.builder(
                itemCount: lista.length,
                itemBuilder: (_, index) {
                  Tarefa tarefa = lista[index];
                  return TarefaItem(tarefa, service);
                },
              );
            },
          ),
        ),
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.white,
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(23, 151, 179, 1),
        onPressed: () {
          Navigator.of(context).pushNamed('/create');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          backgroundColor: Color.fromRGBO(142, 215, 206, 10),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromRGBO(142, 215, 206, 10),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Color.fromRGBO(142, 215, 206, 10),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
              backgroundColor: Color.fromRGBO(142, 215, 206, 10),
            ),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

class TarefaItem extends StatelessWidget {
  const TarefaItem(
    this.tarefa,
    this.service,
  );

  final Tarefa tarefa;
  final TarefaService service;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(tarefa.id!),
      background: Container(
        color: Colors.green,
      ),
      onDismissed: (_) {
        service.delete(tarefa);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${tarefa.texto} foi removido com sucesso."),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                border: Border.all(
                    color: Color.fromRGBO(50, 151, 399, 50), width: 0.2)),
            child: ListTile(
              //value: tarefa.finalizada,
              title: Text(
                tarefa.texto,
                style: (TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 35,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'GrowingGarden',
                )),
              ),
              subtitle: Text("Mínimo: ${tarefa.min} %. \n"
                  "Máximo: ${tarefa.max} %. \n"),
              trailing: Container(
                width: 100,
                child: Row(
                  children: <Widget>[
                    //Text("Mínimo: ${tarefa.min} %"),
                    //Text("Máximo: ${tarefa.max} %"),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/edit', arguments: tarefa);
                      },
                      icon: Icon(Icons.edit_outlined),
                      color: Colors.blue.shade800,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              //onChanged: (value) {
              //  service.update(tarefa.id!, value!);
              // },
            ),
          ),
        ],
      ),
    );
  }
}
