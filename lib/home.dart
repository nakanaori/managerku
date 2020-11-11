import 'package:flutter/material.dart';
import 'package:managerku/reminder.dart';

import 'crud.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CRUD dbhelper = CRUD();
  Future<List<Reminder>> future;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    setState(() {
      future = dbhelper.getReminder();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color darkOrange = Color(0xffFF7D45);
    Color lightOrange = Color(0xffF9AE91);
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
        leading: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => print('Calender mode'),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings), onPressed: () => print('Setting'))
        ],
        flexibleSpace: Container(
          color: darkOrange,
        ),
      ),
      backgroundColor: lightOrange,
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("Add Data"),
        backgroundColor: darkOrange,
        foregroundColor: Colors.white,
        splashColor: lightOrange,
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: FutureBuilder<List<Reminder>>(
        future: future,
        builder: (context, snapshot) {
          List<String> date = [];
          Map<String, List<Reminder>> data = Map();
          if (snapshot.hasData) {
            for (Reminder reminder in snapshot.data) {
              String thisDate = reminder.dateToString();
              if (date.contains(thisDate) == false) date.add(thisDate);
              if (data[thisDate] == null) data[thisDate] = List();
              data[thisDate].add(reminder);
            }
            return Column(
              children: date.map((value) => createCard(value, data)).toList(),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Card createCard(String value, Map<String, List<Reminder>> data) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(value),
          ListView(shrinkWrap: true, children: createData(data[value])),
        ],
      ),
    );
  }

  List<Widget> createData(List<Reminder> reminders) {
    List<Widget> data = [];
    for (Reminder reminder in reminders) {
      data.add(createRow(reminder));
    }
    return data;
  }

  InkWell createRow(Reminder reminder) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Text(reminder.timeFromToString() +
              (reminder.timeTo == null ? "" : ":" + reminder.timeToToString())),
          Text(reminder.title)
        ],
      ),
    );
  }
}
