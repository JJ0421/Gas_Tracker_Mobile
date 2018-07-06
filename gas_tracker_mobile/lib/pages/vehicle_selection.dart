import 'package:flutter/material.dart';

class VehicleSelect extends StatelessWidget{
final String details;
VehicleSelect(this.details);


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text('Selected Vehicle'),
          backgroundColor: Colors.green,
        ),
        body: new Text(details)
      ),
    );
  }



}