import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/entities/estufa.dart';
import 'package:tarefas_app/entities/tarefa.dart';
import 'package:tarefas_app/services/tarefa.service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:tarefas_app/views/android/bottow.view.dart';

class TempHumid extends StatefulWidget {
  @override
  _TempHumidState createState() => _TempHumidState();
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
EstufaModel? model;

class _TempHumidState extends State<TempHumid> {
  int _currentIndex = 0;

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
        child: Column(
          children: [
            //Padding(padding: ),
            SizedBox(height: 30),
            /* Text(
            "Informações",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Homegarden'),
          ),
          SizedBox(height: 30),*/
            /* Flexible(
            child: Container(
              // height: 1000,
              //  width: 24,
              color: Colors.white,
            ),
          ),*/
            Flexible(
              //flex: 2,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: firestore.collection('climambiente').snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  model = EstufaModel.fromMap(
                    snapshot.data!.docs[0].data(),
                  );

                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            //color: Colors.white,

                            // borderRadius:
                            //   BorderRadius.all(Radius.circular(8.0)),

                            borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        )),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "  UMIDADE DA CULTURA  ",
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
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /*Text("  lista ° C  ",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    )),*/
                                  Text("  ${model!.umidadeSolo.toString()} %  ",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                50, 151, 399, 50),
                                            width: 1.9)),
                                    height: 200,
                                    //  width: 24,
                                    //color: Colors.white,
                                    child: FAProgressBar(
                                      animatedDuration:
                                          Duration(milliseconds: 900),
                                      direction: Axis.vertical,
                                      backgroundColor: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      size: 40,
                                      verticalDirection: VerticalDirection.up,
                                      border: null,
                                      progressColor: Colors.blue.shade300,
                                      currentValue: model!.umidadeSolo!.toInt(),
                                      displayText: '%',
                                      displayTextStyle: TextStyle(
                                          //color: Colors.black54,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'OpenSans'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            (model!.ligada == true)
                                ? Text(" Solenóide Ligada ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ))
                                : Text(" Solenóide Desligada ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    )),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height - 546),
                        decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.shade200,
                                blurRadius:
                                    5.0, // has the effect of softening the shadow
                                spreadRadius:
                                    5.0, // has the effect of extending the shadow
                                offset: Offset(
                                  3.0, // horizontal, move right 10
                                  30.0, // vertical, move down 10
                                ),
                              )
                            ],
                            /* gradient: new LinearGradient(
                              colors: [
                                Colors.green.shade100,
                                Colors.red.shade100
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              tileMode: TileMode.clamp),*/
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                            )),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "ESTUFA",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans'),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.yellow.shade50,
                                          blurRadius:
                                              40.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              1.0, // has the effect of extending the shadow
                                          offset: Offset(
                                            7.0, // horizontal, move right 10
                                            10.0, // vertical, move down 10
                                          ),
                                        )
                                      ],
                                      // borderRadius:
                                      //   BorderRadius.all(Radius.circular(8.0)),
                                      border: Border.lerp(
                                        Border(
                                            right: BorderSide(
                                                color: Color.fromRGBO(
                                                    142, 215, 206, 10),
                                                width: 2,
                                                style: BorderStyle.solid)),
                                        Border(
                                            right: BorderSide(
                                                color: Color.fromRGBO(
                                                    142, 215, 206, 10),
                                                width: 1,
                                                style: BorderStyle.none)),
                                        0,
                                      )),
                                  //Border.all(
                                  //  color: Color.fromRGBO(50, 151, 399, 50),
                                  // width: 1.3)),
                                  //color: Color.fromRGBO(142, 215, 206, 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/sun.svg',
                                            height: 120,
                                          ),
                                          Text(
                                              "${model!.temperatura.toString()}° C  ", // INSERIR DADOS AQUI
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.shade50,
                                        blurRadius:
                                            40.0, // has the effect of softening the shadow
                                        spreadRadius:
                                            1.0, // has the effect of extending the shadow
                                        offset: Offset(
                                          7.0, // horizontal, move right 10
                                          10.0, // vertical, move down 10
                                        ),
                                      )
                                    ],
                                  ),
                                  /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                             border: Border.all(
                                 color: Color.fromRGBO(50, 151, 399, 50),
                                  width: 1.3)),*/
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/water.svg',
                                            height: 120,
                                          ),
                                          Text(
                                              "${model!.umidade.toString()} %  ", // INSERIR DADOS AQUI
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
<<<<<<< HEAD
      floatingActionButton: FloatingActionButton(
=======
      /*floatingActionButton: FloatingActionButton(
>>>>>>> b9b45f475f3dca936d055418898f212bc53545f7
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(23, 151, 179, 1),
        onPressed: () {
          Navigator.of(context).pushNamed('/create');
        },
      ),*/
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
