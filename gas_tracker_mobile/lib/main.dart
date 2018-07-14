import 'package:flutter/material.dart';
import './pages/find_vehicle.dart';
import './pages/home.dart';

void main() => runApp(new Home());

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
        body: new Makes()
      ),
    );
  }
}