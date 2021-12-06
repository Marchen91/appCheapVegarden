import 'dart:ui';

import 'package:cheapvegarden_app/entities/irrigacaoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Irrigation extends StatefulWidget {
  final Widget? child;

  Irrigation({Key? key, this.child}) : super(key: key);

  _IrrigationState createState() => _IrrigationState();
}

class _IrrigationState extends State<Irrigation> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late List<charts.Series<IrrigacaoModel, int>> _seriesDadosGrafico;
  late List<IrrigacaoModel> meusDados;

  _gerarDados(meusDados) {
    _seriesDadosGrafico = <charts.Series<IrrigacaoModel, int>>[];
    _seriesDadosGrafico.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.greenAccent),
        id: 'Fluxo',
        data: meusDados,
        domainFn: (IrrigacaoModel irrigacaoModel, _) =>
            irrigacaoModel.data!.toDate().minute,
        measureFn: (IrrigacaoModel irrigacaoModel, _) => irrigacaoModel.fluxo,
      ),
    );
  }

  late IrrigacaoModel model;

  int _currentIndex = 1;
  int index = 0;
  String? texto;
  bool fim = false;

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

  Widget _lerDados(BuildContext context, firestore) {
    var tamanho;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: firestore.collection('irrigacao2').orderBy('data').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<IrrigacaoModel> irrigacaoModel = snapshot.data!.docs
              .map((documentSnapshot) =>
                  IrrigacaoModel.fromMap(documentSnapshot.data()))
              .toList();

          tamanho = irrigacaoModel.length;
          if (tamanho == 60) {
            irrigacaoModel.clear();
            fim = true;
          }
          if (tamanho == 0) fim = false;
          if (!fim) return _buildChart(context, irrigacaoModel);
          irrigacaoModel.clear();
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildChart(
      BuildContext context, List<IrrigacaoModel> irrigacaoModel) {
    meusDados = irrigacaoModel;
    _gerarDados(meusDados);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'FLUXO',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 20.0,
                  width: 500,
                  child: charts.LineChart(
                    _seriesDadosGrafico,
                    defaultRenderer: new charts.LineRendererConfig(
                      includeArea: true,
                      stacked: true,
                      includePoints: true,
                    ),
                    animate: true,
                    animationDuration: Duration(milliseconds: 1),
                    domainAxis: new charts.NumericAxisSpec(
                      // showAxisLine: true,
                      viewport: new charts.NumericExtents(0, 60),
                    ),
                    // domainAxis: new charts.EndPointsTimeAxisSpec(),
                    behaviors: [
                      new charts.ChartTitle('Fluxo (L/min)',
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      new charts.ChartTitle('Minutos',
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade200,
                blurRadius: 5.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
                offset: Offset(
                  3.0, // horizontal, move right 10
                  30.0, // vertical, move down 10
                ),
              )
            ],
            color: Colors.white,
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "VOLUME MENSAL",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Flexible(
                child: SizedBox(
                  // height: 20,
                  width: 500,
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

                      dynamic documento = snapshot.data!;

                      for (var doc in documento.docs) {
                        var mes =
                            meses[(doc.data()['data'].toDate().month) - 1];
                        double volume = doc.data()["volume"];

                        if (dados.containsKey(mes))
                          dados[mes] = dados[mes]! + volume;
                        else
                          dados[mes] = volume;
                      }
                      return Center(
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'MÊS',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'VOLUME (L)',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows: dados.keys
                              .map((conteudo) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                        Text(
                                          conteudo,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${dados[conteudo]!.toStringAsFixed(2)}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: _lerDados(context, firestore),
              ),
            ],
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
            Navigator.of(context).pushNamed('/login');
          }
        }),
      ),
    );

    // ignore: dead_code
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<IrrigacaoModel>('model', model));
  }
}
