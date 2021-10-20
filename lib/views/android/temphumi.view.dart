import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/entities/tarefa.dart';
import 'package:tarefas_app/services/tarefa.service.dart';

class TempHumid extends StatelessWidget {
  int _currentIndex = 0;
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
          "Informações",
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: 'Homegarden'),
        ),
        SizedBox(height: 30),
        Flexible(
            child: Container(
          color: Colors.white,
        )),
        Flexible(
          flex: 2,
          child: Consumer<TarefaService>(
            builder: (context, service, child) {
              var lista = service.tarefas;

              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "ESTUFA",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans'),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            // borderRadius:
                            //   BorderRadius.all(Radius.circular(8.0)),
                            border: Border.lerp(
                          Border(
                              right: BorderSide(
                                  color: Color.fromRGBO(142, 215, 206, 10),
                                  width: 2,
                                  style: BorderStyle.solid)),
                          Border(
                              right: BorderSide(
                                  color: Color.fromRGBO(142, 215, 206, 10),
                                  width: 1,
                                  style: BorderStyle.none)),
                          0,
                        )),
                        //Border.all(
                        //  color: Color.fromRGBO(50, 151, 399, 50),
                        // width: 1.3)),
                        //color: Color.fromRGBO(142, 215, 206, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/sun.svg',
                                  height: 120,
                                ),
                                Text("${lista[1].temperatura.toString()}° C  ",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        /* decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                           border: Border.all(
                               color: Color.fromRGBO(50, 151, 399, 50),
                                width: 1.3)),*/
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/water.svg',
                                  height: 120,
                                ),
                                Text("${lista[1].humidade.toString()} %  ",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(23, 151, 179, 1),
        onPressed: () {
          Navigator.of(context).pushNamed('/create');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color.fromRGBO(142, 215, 206, 10),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromRGBO(142, 215, 206, 10),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Color.fromRGBO(142, 215, 206, 10),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(Icons.camera),
            label: 'Camera',
            backgroundColor: Color.fromRGBO(142, 215, 206, 10),
          ),
        ],
        /* onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },*/
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

/*

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
*/