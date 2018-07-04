import 'package:flutter/material.dart';
import '../services/web_client.dart';
import 'dart:async';

class Makes extends StatefulWidget {
  State<StatefulWidget> createState(){
    return MakesState();
  }
}

class MakesState extends State<Makes> {
  List<Entry> data = new List<Entry>();

  @override
  void initState(){
    super.initState();
    this.getEntryData();
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
      for(int j = 0; j < models.length; j++){
        List<Entry> yearsEntries = new List<Entry>();
        List years = models[j]["years"];
        for(int k = 0; k < years.length; k++){
          Entry yearEntry = new Entry("          "+years[k].toString());
          yearsEntries.add(yearEntry);
        }
        Entry modelEntry = new Entry("     "+models[j]["model"], yearsEntries);
        modelsEntry.add(modelEntry);
      }
      Entry entry = new Entry(myList[i]["make"], modelsEntry);
      myEntryList.add(entry);
    }

    setState(() => data = myEntryList);

    return myEntryList;
  }

  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => EntryItem(data[index]),
      itemCount: data.length,
    );
  }
}

class Entry {
  final String title;
  final List<Entry> children;
  Entry(this.title, [this.children = const <Entry>[]]);
}


// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
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
