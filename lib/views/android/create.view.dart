import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/entities/tarefa.dart';
import 'package:tarefas_app/services/tarefa.service.dart';
import 'package:flutter/services.dart';
import 'package:tarefas_app/views/android/bottow.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarefas_app/views/android/lista.view.dart';

class CreateView extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // atributos da classe:
  var _formKey = GlobalKey<FormState>();
  String? descricao;
  String? minimo;
  String? maximo;
  var n;
  var n2;
  int _currentIndex = 2;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        firestore
            .collection('users')
            .doc(auth.currentUser?.uid)
            .collection('cultura')
            .add({
          'cultura': descricao,
          'valor minimo': minimo,
          'valor maximo': maximo
        });
        /*firestore.collection('users').doc(auth.currentUser?.uid).collection('cultura').doc('cultura'.).set({
          'cultura': descricao,
          'valor minimo': minimo,
          'valor maximo': maximo
        });*/

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => ListaView()), (route) => false);
      } on FirebaseAuthException catch (ex) {
        print(ex.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CHEAPVEGARDEN",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Color.fromRGBO(142, 215, 206, 10),
        actions: [
          TextButton(
            onPressed: () {
              _register(context);

              /* if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                var tarefa = Tarefa(texto: descricao!, min: n, max: n2);
                var service =
                    Provider.of<TarefaService>(context, listen: false);

                service.create(tarefa);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("${tarefa.texto} foi adicionado com sucesso."),
                  ),
                );
              }*/
            },
            child: Text(
              "SALVAR",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Nova Cultura",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Homegarden'),
                ),
                SizedBox(height: 35),
                TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                      labelText: "Cultura",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.agriculture_outlined)),
                  onSaved: (value) => this.descricao = value,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Campo obrigatório";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Umidade Mínima ",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.water_damage),
                      suffix: Text('%')),
                  onSaved: (valor) => this.minimo = valor,
                  validator: (valor) {
                    n = num.tryParse(valor!);
                    if (valor.length == 0) {
                      return "Campo obrigatório";
                    }
                    if (num.tryParse(valor)! > 100) {
                      return "Umidade máxima de 100%.";
                    }
                    if (num.tryParse(valor)! < 0) {
                      return "Umidade mínima de 0%.";
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Umidade Máxima ",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.water_damage_outlined),
                      suffix: Text('%')),
                  onSaved: (valormax) => this.maximo = valormax,
                  validator: (valormax) {
                    n2 = num.tryParse(valormax!);

                    if (n == null) {
                      return "Valor Mínimo obrigatório";
                    }

                    if (valormax.length == 0) {
                      return "Campo obrigatório";
                    }
                    if (num.tryParse(valormax)! > 100) {
                      return "Umidáde máxima de 100%.";
                    }
                    if (num.tryParse(valormax)! <= n) {
                      return "Umidade mínima: ${n}%.";
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: Color.fromRGBO(142, 215, 206, 10),
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.thermostat),
          Icon(Icons.auto_graph),
          Icon(Icons.eco),
        ],
        onTap: ((index) {
          print(index);
          if (index == 0) {
            Navigator.of(context).pushNamed('/');
          }
          if (index == 1) {
            Navigator.of(context).pushNamed('/list');
          } else if (index == 2) {
            Navigator.of(context).pushNamed('/create');
          }
        }),
      ),

      /*  BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          backgroundColor: Color.fromRGBO(142, 215, 206, 10),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.thermostat),
              label: 'Home',
              backgroundColor: Color.fromRGBO(142, 215, 206, 10),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph),
              label: 'Search',
              backgroundColor: Color.fromRGBO(142, 215, 206, 10),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.eco),
              label: 'Camera',
              backgroundColor: Color.fromRGBO(142, 215, 206, 10),
            ),
          ]),*/
    );
  }
}
