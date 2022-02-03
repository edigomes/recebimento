import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pedidos/widgets/auth_card.dart';

class AuthScreen extends StatelessWidget {
  //const AuthScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue,
                Colors.blueAccent,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 40,
                  ),
                  //transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepOrange.shade900,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Recebimento de Mercadoria',
                    style: TextStyle(
                        fontFamily: 'Anton',
                        fontSize: 18,
                        color:
                            Theme.of(context).accentTextTheme.headline6.color),
                  ),
                ),
                AuthCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
