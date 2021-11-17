import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Irrigation extends StatefulWidget {
  @override
  _IrrigationState createState() => _IrrigationState();
}

class _IrrigationState extends State<Irrigation> {
  int _currentIndex = 1;

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
            Flexible(
              child: Column(
                children: [
                  Container(
                    child: graficoFluxo(),
                  ),
                  Container(
                    child: tabelaVolumeMensal(),
                  ),
                ],
              ),
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

tabelaVolumeMensal() {
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
        DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'MÊS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'VOLUME',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(
                  Text('Janeiro'),
                ),
                DataCell(
                  Text('20.3'),
                ),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(
                  Text('Fevereiro'),
                ),
                DataCell(
                  Text('14.3'),
                ),
              ],
            ),
          ],
        ),
        // ),
        // Table(
        //   defaultColumnWidth: FixedColumnWidth(150.0),
        //   border: TableBorder(
        //     top: BorderSide(
        //       color: Colors.black,
        //       style: BorderStyle.solid,
        //       width: 2,
        //     ),
        //     bottom: BorderSide(
        //       color: Colors.black,
        //       style: BorderStyle.solid,
        //       width: 2,
        //     ),
        //     left: BorderSide(
        //       color: Colors.black,
        //       style: BorderStyle.solid,
        //       width: 2,
        //     ),
        //     right: BorderSide(
        //       color: Colors.black,
        //       style: BorderStyle.solid,
        //       width: 2,
        //     ),
        //     horizontalInside: BorderSide(
        //       color: Colors.black,
        //       style: BorderStyle.solid,
        //       width: 2,
        //     ),
        //     verticalInside: BorderSide(
        //       color: Colors.black,
        //       style: BorderStyle.solid,
        //       width: 2,
        //     ),
        //   ),
        //   children: [
        //     _linhaTable("MÊS, VOLUME"),
        //     _linhaTable("JAN, 40.2"),
        //     _linhaTable("FEV, 32.1"),
        //     _linhaTable("ABR, 21.2"),
        //   ],
      ],
    ),
  );
}

// _linhaTable(String listaDados) {
//   return TableRow(
//     children: listaDados.split(',').map((dados) {
//       return Container(
//         alignment: Alignment.center,
//         child: Text(
//           dados,
//           style: TextStyle(fontSize: 18),
//         ),
//         padding: EdgeInsets.all(2),
//       );
//     }).toList(),
//   );
// }
