import 'package:flutter/material.dart';
import './pages/find_vehicle.dart';
import './pages/vehicle_selection.dart';

void main() => runApp(new FindCar()
);

class FindCar extends StatefulWidget{
  State<StatefulWidget> createState() {
    return FindCarState();
  }
}

class FindCarState extends State<FindCar>{
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