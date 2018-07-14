import 'package:flutter/material.dart';
import 'dart:async';
import '../database/database.dart';
import '../main.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: EmptyHome(),
      ),
    );
  }
}

class EmptyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmptyHomeState();
  }
}

class EmptyHomeState extends State<EmptyHome> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('No saved vehicles', style: TextStyle(fontSize: 30.0))
          ]),
          Container(
              padding: EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                      minWidth: 100.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) {
                              return new FindCar();
                            }),
                          );
                        },
                        child: Text(
                          'Begin',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
