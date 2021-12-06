import 'package:cheapvegarden_app/entities/culturaModel.dart';
import 'package:cheapvegarden_app/views/android/lista.view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditView extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // atributos da classe:
  var _formKey = GlobalKey<FormState>();

  String? descricao;
  int? minimo;
  int? maximo;
  String? uid;

  var n;
  var n2;

  int _currentIndex = 2;
  DocumentReference? ref;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
//final Map<Tarefa, Tarefa> _formData = {};

  /*void _loadFormData(Tarefa tarefa){
    _formData['id']= tarefa.id!;
    _formData['descricao']= tarefa.texto;
    _formData['minimo']= tarefa.min as String;
    _formData['maximo']= tarefa.max as String;
       


  }*/
  Future _edit(BuildContext context, String? id) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      this.uid = id;
      print(uid);

      try {
        firestore
            .collection('users')
            .doc(auth.currentUser?.uid)
            .collection('cultura')
            .doc(uid)
            .update({
          //'uid': ref!.id,
          'cultura': descricao,
          'valorminimo': minimo,
          'valormaximo': maximo
        });

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => ListaView()), (route) => false);
      } on FirebaseAuthException catch (ex) {
        print(ex.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final culturaArg =
        ModalRoute.of(context)!.settings.arguments as CulturaModel;
    String culturaArgMin = culturaArg.min.toString();
    String culturaArgMax = culturaArg.max.toString();

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
              uid = culturaArg.uid;
              _edit(context, uid);
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
                  "Editar Cultura",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Homegarden'),
                ),
                SizedBox(height: 35),
                TextFormField(
                  initialValue: culturaArg.cultura,
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
                  initialValue: culturaArgMin,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Umidade Mínima ",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.water_damage),
                      suffix: Text('%')),
                  onSaved: (valor) => this.minimo = int.parse(valor!),
                  validator: (valor) {
                    //var valorMin;
                    /*if (n == null) {
                      valorMin = "0";
                      n = 0;
                    }*/
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
                    /*   if (n < 0) {
                      return "Valor não pode ser negativo.";
                    }
                    if (n > 100) {
                      return "Valor não pode ser maior que 100 %.";
                    }
*/
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 10),
                TextFormField(
                  //enabled: false,
                  initialValue: culturaArgMax,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Umidade Máxima ",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.water_damage_outlined),
                      suffix: Text('%')),
                  onSaved: (valormax) => this.maximo = int.parse(valormax!),
                  validator: (valormax) {
                    if (valormax!.length == 0) {
                      return "Campo obrigatório";
                    }
                    n2 = num.tryParse(valormax);
                    if (n == null) {
                      n = culturaArg.min;

                      return "${Validation(n, n2)}";
                    } else if (Validation(n, n2) == null) {
                      return null;
                    } else {
                      return "${Validation(n, n2)}";
                    }
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
            Navigator.of(context).pushNamed('/irrigation');
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

String? Validation(int number, int number2) {
  if (number2 > 100) {
    return "Umidáde máxima de 100%.";
  }
  if (number2 <= number) {
    return "Umidade mínima: ${number}%.";
  }
}
