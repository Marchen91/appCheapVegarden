import 'package:cheapvegarden_app/views/android/lista.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterView extends StatefulWidget {
  // atributos da classe:
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var _formKey = GlobalKey<FormState>();
  String? nome, email, senha, apelido, fone;
  PhoneAuthCredential? telefone;

  Future _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        /* n = num.tryParse(valor!);

        telefone = PhoneAuthCredential.Parse(fone!);*/
        await auth.createUserWithEmailAndPassword(
            email: email!, password: senha!);

        await auth.currentUser?.updateDisplayName(nome);

        //await auth.currentUser?.updatePhoneNumber(telefone!);
        firestore
            .collection('users')
            .doc(auth.currentUser?.uid)
            .set({'apelido': apelido, 'data': DateTime.now()});

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => ListaView()), (route) => false);
      } on FirebaseAuthException catch (ex) {
        Fluttertoast.showToast(
            msg: ex.message!,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            fontSize: 24);
      }
    }
  }

  int _currentIndex = 2;

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
                  "Registro",
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
                      labelText: "Nome",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)),
                  onSaved: (value) => nome = value,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Mínimo de 3 caracteres.";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email),
                    //suffix: Text('%')
                  ),
                  onSaved: (valor) => email = valor,
                  validator: (valor) {
                    if (valor!.isEmpty) {
                      return "Campo obrigatório.";
                    }
                    if (!valor.contains("@")) {
                      return "Tipo inválido.";
                    }
                    if (!valor.contains(".")) {
                      return "Tipo inválido.";
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    //suffix: Text('%')
                  ),
                  obscureText: true,
                  onSaved: (valorsenha) => senha = valorsenha,
                  validator: (valorsenha) {
                    if (valorsenha!.length < 6) {
                      return "Mínimo 6 dígitos";
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 10),
                /*TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Apelido",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.water_damage_outlined),
                      suffix: Text('%')),
                  onSaved: (valorapelido) => apelido = valorapelido,
                  validator: (valorapelido) {
                    if (valorapelido!.length < 6) {
                      return "Mínimo 6 dígitos";
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),*/
              ],
            ),
          ),
        ),
      ),
      /*bottomNavigationBar: CurvedNavigationBar(
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
      ),*/

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
