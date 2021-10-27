import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
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
    );
  }
}
