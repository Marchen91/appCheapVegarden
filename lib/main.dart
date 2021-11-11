import 'package:flutter/material.dart';
import 'dart:io';

import 'package:tarefas_app/views/android/android.app.dart';
import 'package:tarefas_app/views/ios/ios.app.dart';
import 'package:firebase_core/firebase_core.dart';

<<<<<<< HEAD
void main() => runApp(AndroidApp());
=======
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(Platform.isIOS ? IosApp() : AndroidApp());
  runApp(AndroidApp());
}


>>>>>>> dcd3423ffe2aeca1b5aff72fc6aa734dd49ce8c7

/*
Estados do Widget
StatelessWidget => executa build() uma única vez.
StatefulWidget => executa build() a cada alteração de estado (setState())

Estado Global (Provider)
Widget Pai (estado global)
Widget1 (form) -> altero estado global
Widget2 (atualiza de acordo com a mudança de estado feita no Widget 1) <- observa o estado global.


                        Service (Global)

Widget1 (observando alterações no Service)     Widget2 (altera o service)
*/