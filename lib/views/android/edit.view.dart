import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/entities/tarefa.dart';
import 'package:tarefas_app/services/tarefa.service.dart';
import 'package:flutter/services.dart';

class EditView extends StatelessWidget {
  // atributos da classe:
  var _formKey = GlobalKey<FormState>();

  String? descricao;
  String? minimo;
  String? maximo;

  var n;
  var n2;
//final Map<Tarefa, Tarefa> _formData = {};

  /*void _loadFormData(Tarefa tarefa){
    _formData['id']= tarefa.id!;
    _formData['descricao']= tarefa.texto;
    _formData['minimo']= tarefa.min as String;
    _formData['maximo']= tarefa.max as String;
       


  }*/

  @override
  Widget build(BuildContext context) {
    final tarefaArg = ModalRoute.of(context)!.settings.arguments as Tarefa;
    String tarefaArgMin = tarefaArg.min.toString();
    String tarefaArgMax = tarefaArg.max.toString();

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
                tarefaArg.texto = descricao!;
                tarefaArg.min = n;
                tarefaArg.max = n2;

                //tarefa = Tarefa(texto: descricao!, min: n, max: n2);
                var service =
                    Provider.of<TarefaService>(context, listen: false);
                service.update(tarefaArg.id!, tarefaArg.finalizada);

                /*service.update(tarefaArg.id!, tarefaArg.texto,
                    tarefaArg.finalizada, tarefaArg.min, tarefaArg.max);*/
                //service.create(tarefa);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("${tarefaArg.texto} foi editada com sucesso."),
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
                "Editar Cultura",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Homegarden'),
              ),
              SizedBox(height: 35),
              TextFormField(
                initialValue: tarefaArg.texto,
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
                initialValue: tarefaArgMin,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Umidade Mínima ",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.water_damage),
                    suffix: Text('%')),
                onSaved: (valor) => this.minimo = valor,
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
                initialValue: tarefaArgMax,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Umidade Máxima ",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.water_damage_outlined),
                    suffix: Text('%')),
                onSaved: (valormax) => this.maximo = valormax,
                validator: (valormax) {
                  if (valormax!.length == 0) {
                    return "Campo obrigatório";
                  }
                  n2 = num.tryParse(valormax);
                  if (n == null) {
                    n = tarefaArg.min;

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
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
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
