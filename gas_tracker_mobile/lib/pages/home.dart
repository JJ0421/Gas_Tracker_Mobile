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
  List<Map<String, dynamic>> dbData;
  VehicleDatabase db;

  @override
  void dispose() {
    db.closeDb();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    db = VehicleDatabase();
    db.initDB();
    db.selectAll().then((map) {
      setState(() {
        dbData = map;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = EmptyHome();

    if (dbData != null) {
      if (dbData.length > 0) {
        print(dbData);
        widget = HomeData(dbData);
      }
    }

    return MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class HomeData extends StatefulWidget {
  final List<Map<String, dynamic>> dbData;

  HomeData(this.dbData);

  @override
  State<StatefulWidget> createState() {
    return HomeDataState(dbData);
  }
}

class HomeDataState extends State<HomeData> {
  List<Map<String, dynamic>> data;

  HomeDataState(this.data);

  @override
  Widget build(BuildContext context) {
    String mpg;
    String miles;
    VehicleDatabase db = VehicleDatabase();
    return new Scaffold(
        appBar: AppBar(
          title: Text('Saved Vehicles'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                mpg = data[index]['mpg'].toString();
                miles = data[index]['miles'].toString();
                return new Card(
                    child: Container(
                        child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(data[index]['year'] +
                          ' ' +
                          data[index]['make'] +
                          ' ' +
                          data[index]['model']),
                      subtitle: Column(
                        children: [
                          Row(children: [
                            Text('MPG: ' + mpg),
                          ]),
                          Row(children: [
                            Text('Miles Recorded: ' + miles),
                          ])
                        ],
                      ),
                      trailing: IconButton(
                        icon: new Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          db.deleteVehicle(data[index]['id']).then((res) {
                            db.selectAll().then((map) {
                              data = map;
                            });
                          });
                        },
                        tooltip: 'Delete this item',
                      ),
                    ),
                  ],
                )));
              }),
        ));
  }
}
