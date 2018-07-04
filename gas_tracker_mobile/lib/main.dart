import 'package:flutter/material.dart';
import './pages/find_vehicle.dart';

void main() => runApp(new FindCar()
);

class FindCar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text('Find your vehicle'),
          backgroundColor: Colors.green,
        ),
        body: new Makes()
      ),
    );
  }
}