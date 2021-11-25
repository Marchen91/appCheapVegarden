import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tarefas_app/entities/irrigacaoModel.dart';
import "package:collection/collection.dart";

class Irrigation extends StatefulWidget {
  @override
  _IrrigationState createState() => _IrrigationState();
}

class _IrrigationState extends State<Irrigation> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late IrrigacaoModel model;

  int _currentIndex = 1;
  int index = 0;
  String? texto;
  List<String> meses = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];

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
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "VOLUME MENSAL",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: StreamBuilder(
                  stream: firestore
                      .collection('irrigacao')
                      .orderBy('data')
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    Map<String, double> dados = Map<String, double>();

                    dynamic x = snapshot.data!;

                    for (var doc in x.docs) {
                      var mes = doc.data()['data'].toDate().month.toString();
                      double volume = doc.data()["volume"];

                      // completar a partir daqui

                      if (dados.containsKey(mes))
                        dados[mes] = dados[mes]! + volume;
                      else
                        dados[mes] = volume;
                    }
                    return DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'MÊS',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'VOLUME',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: dados.keys
                          .map((e) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text(e),
                                    // _mes = (e.data()["data"].toDate().month),
                                    // Text(
                                    //   meses[(e.data()["data"].toDate().month) -
                                    //           1]
                                    //       .toString(),
                                    // ),
                                  ),
                                  DataCell(
                                    Text(dados[e].toString()),
                                  ),
                                ],
                              ))
                          .toList(),
                    );
                  }),
            ),
            Container(
              child: graficoFluxo(),
            ),
          ],
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
            Navigator.of(context).pushNamed('/login');
          }
        }),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<IrrigacaoModel>('model', model));
  }
}

graficoFluxo() {
  return Container(
    width: double.infinity,
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(40.0),
        topRight: const Radius.circular(40.0),
      ),
    ),
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "GRÁFICO TEMPO REAL",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ],
    ),
  );
}
