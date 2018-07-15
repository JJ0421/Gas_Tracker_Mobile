import 'package:flutter/material.dart';
import '../services/web_client.dart';
import 'dart:async';
import '../database/database.dart';

class VehicleSelect extends StatelessWidget {
  final String make;
  final String model;
  final String year;

  VehicleSelect(this.make, this.model, this.year);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text('Selected Vehicle'),
          backgroundColor: Colors.green,
        ),
        body: new VehicleInfo(make, model, year),
      ),
    );
  }
}

class VehicleInfo extends StatefulWidget {
  final String make;
  final String model;
  final String year;
  VehicleInfo(this.make, this.model, this.year);

  State<StatefulWidget> createState() {
    return VehicleInfoState(make, model, year);
  }
}

class VehicleInfoState extends State<VehicleInfo> {
  String make;
  String model;
  String year;
  String mpg = "";
  String data_key = "";

  VehicleDatabase db;

  VehicleInfoState(this.make, this.model, this.year);

  @override
  void dispose(){
    db.closeDb();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    db = VehicleDatabase();
    db.initDB;
    data_key = (make + model + year).toLowerCase().replaceAll(" ", "");
    this.getMPG();    
  }

  Future<String> getMPG() async {
    WebClient client = new WebClient();
    String str = "";
    await client
        .getVehicleInfo(data_key)
        .then((data) {
      str = data;
    });

    setState(() {
      mpg = str;
      print(mpg);
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        Container(
            padding: EdgeInsets.only(bottom: 70.0, top: 20.0),
            child: Text('Is this your vehicle?',
                style: TextStyle(fontSize: 40.0))),
        Container(
            padding: EdgeInsets.only(left: 10.0, bottom: 13.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Year: ' + this.year,
                  style: TextStyle(fontSize: 25.0), textAlign: TextAlign.left)
            ])),
        Container(
            padding: EdgeInsets.only(left: 10.0, bottom: 13.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Make: ' + this.make,
                  style: TextStyle(fontSize: 25.0), textAlign: TextAlign.left)
            ])),
        Container(
            padding: EdgeInsets.only(left: 10.0, bottom: 13.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Model: ' + this.model,
                  style: TextStyle(fontSize: 25.0), textAlign: TextAlign.left)
            ])),
        Container(
            padding: EdgeInsets.only(left: 10.0, bottom: 13.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('MPG: ' + this.mpg,
                  style: TextStyle(fontSize: 25.0), textAlign: TextAlign.left)
            ])),
        Container(
            padding: EdgeInsets.only(top: 35.0),
            child: Image(image: AssetImage('assets/icon.png'))),
        Container(
          padding: EdgeInsets.only(top: 50.0),
          child: ButtonTheme(
              minWidth: 150.0,
              child: RaisedButton(
                onPressed: () {
                  print(mpg);
                  db.addVehicle(data_key, year, make, model, int.parse(mpg));
                },
                child: Text('Save', style: TextStyle(color: Colors.white)),
                color: Colors.blueAccent,
              )),
        ),
      ],
    );
  }
}
