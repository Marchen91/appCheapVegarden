import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/entities/tarefa.dart';
import 'package:tarefas_app/services/tarefa.service.dart';
import 'package:flutter/services.dart';

class CreateView extends StatelessWidget {
  // atributos da classe:
  var _formKey = GlobalKey<FormState>();
  String? descricao;
  String? minimo;
  String? maximo;
  var n;
  var n2;

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
              if (_formKey.currentState!.validate()) {
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
              }
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
      body: Form(
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
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
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
                Icons.search,
                color: Colors.white,
              ),
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Color.fromRGBO(142, 215, 206, 10),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.camera,
                color: Colors.white,
              ),
              icon: Icon(Icons.camera),
              label: 'Camera',
              backgroundColor: Color.fromRGBO(142, 215, 206, 10),
            ),
          ]),
    );
  }
}
