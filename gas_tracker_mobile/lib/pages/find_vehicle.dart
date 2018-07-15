import 'package:flutter/material.dart';
import '../services/web_client.dart';
import './vehicle_selection.dart';
import 'dart:async';

class Makes extends StatefulWidget {
  State<StatefulWidget> createState() {
    return MakesState();
  }
}

class MakesState extends State<Makes> {
  List<Entry> data = new List<Entry>();
  bool loading = true;
  static List cachedList;

  @override
  void initState() {
    super.initState();
    if(cachedList == null){
      this.getEntryData();
    }else{
      data = cachedList;
      loading = false;
    }
  }

  Future<List<Entry>> getEntryData() async {
    List<Entry> myEntryList = new List<Entry>();
    List myList = new List<String>();

    WebClient client = new WebClient();
    await client.getMakes().then((data) {
      myList = data;
    });

    for (int i = 0; i < myList.length; i++) {
      List<Entry> modelsEntry = new List<Entry>();
      List models = myList[i]["models"];
      for (int j = 0; j < models.length; j++) {
        List<Entry> yearsEntries = new List<Entry>();
        List years = models[j]["years"];
        for (int k = 0; k < years.length; k++) {
          Entry yearEntry = new Entry("          " + years[k].toString(), [],
              myList[i]["make"], models[j]["model"]);
          yearsEntries.add(yearEntry);
        }
        Entry modelEntry =
            new Entry("     " + models[j]["model"], yearsEntries);
        modelsEntry.add(modelEntry);
      }
      Entry entry = new Entry(myList[i]["make"], modelsEntry);
      myEntryList.add(entry);
    }

    setState(() {
      data = myEntryList;
      cachedList = myEntryList;
      loading = false;
    });

    return myEntryList;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return new Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,
      );
    }
  }
}

class Entry {
  final String title;
  final List<Entry> children;
  final String make;
  final String model;

  Entry(this.title, [this.children = const <Entry>[], this.make, this.model]);
}

class EntryItem extends StatefulWidget {
  final Entry entry;
  EntryItem(this.entry);

  State<StatefulWidget> createState() {
    return EntryItemState(entry);
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItemState extends State<EntryItem> {
  EntryItemState(this.entry);

  final Entry entry;

  _pushDetails(String make, String model, String year) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => new VehicleSelect(make, model, year)));
  }

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title),
        onTap: () {
          String mod = root.model.trim();
          String year = root.title.trim();
          _pushDetails(root.make, mod, year);
        },
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
