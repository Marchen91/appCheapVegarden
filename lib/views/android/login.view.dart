import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/entities/tarefa.dart';
import 'package:tarefas_app/services/tarefa.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarefas_app/views/android/lista.view.dart';
import 'package:tarefas_app/views/android/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int _currentIndex = 1;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _formKey = GlobalKey<FormState>();
  String? email, senha;
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Future _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await auth.signInWithEmailAndPassword(email: email!, password: senha!);

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
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0),
          ),
          //color:
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "CHEAPVEGARDEN   ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(142, 215, 206, 10),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    Image.asset("assets/logo.png"),
                  ],
                ),

                //Image.asset("assets/logo.png"), //IMAGEM 1
              ),
              SizedBox(
                height: 70,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(142, 215, 206, 10),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'OpenSans',
                ),
                onSaved: (value) => email = value,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(142, 215, 206, 10),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'OpenSans',
                ),
                obscureText: true,
                onSaved: (value) => senha = value,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                //color: Colors.white,
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey, // background
                    //onPrimary: Colors.white, // foreground
                  ),
                  //style:ElevatedButton.styleFrom(onSurface: Colors.black),
                  onPressed: () {},
                  child: Text(
                    "Recuperar Senha",
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.2, 1],
                    colors: [
                      Colors.brown.shade300,
                      Color.fromRGBO(142, 215, 206, 10),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: SizedBox.expand(
                  child: ElevatedButton(
                    onPressed: () => _login(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Login   ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              color: Colors.black54),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: SizedBox.expand(
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Login pelo Google  ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              color: Colors.black54),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: SizedBox(
                            child: Image.asset("assets/google.png"), //IMAGEM 3
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ],
                    ),
                    onPressed: null,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                child: ElevatedButton(
                  child: Text(
                    "Cadastre-se",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RegisterView()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
