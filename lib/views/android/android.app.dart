import 'package:flutter/material.dart';
import 'package:tarefas_app/services/tarefa.service.dart';
import 'package:tarefas_app/views/android/create.view.dart';
import 'package:tarefas_app/views/android/edit.view.dart';
import 'package:tarefas_app/views/android/lista.view.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/views/android/temphumi.view.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TarefaService(), // singleton.
      child: MaterialApp(
        // home: ListaView(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => TempHumid(),
          '/create': (context) => CreateView(),
          '/edit': (context) => EditView(),
        },
        initialRoute: '/',
      ),
    );
  }
}
