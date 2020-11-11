import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime dateValue = DateTime.now();
  DateTime timeValue = DateTime.now();
  String notifValue = "Sound";
  List notifType = ["Sound", "Vibrate", "Silent"];
  String soundValue = "Default";
  List soundType = ["Default", "Daydreaming", "Alarm"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Color(0xffff7d43)),
          ),
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Text(
            "Edit Reminder",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          color: Color(0xfff9ae91),
          child: Scrollbar(
            radius: Radius.circular(50),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Reminder Name",
                        style: TextStyle(
                            fontFamily: "Fenix-Regular",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        height: 60,
                        child: TextField(
                          maxLength: 25,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Text(
                        "Reminder Detail",
                        style: TextStyle(
                            fontFamily: "Fenix-Regular",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        height: 170,
                        child: TextField(
                          maxLength: 1000,
                          maxLines: 12,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Text(
                        "Date",
                        style: TextStyle(
                            fontFamily: "Fenix-Regular",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                      ),
                      Container(
                          child: FlatButton(
                        child: Text(
                          dateValue.day.toString() +
                              "/" +
                              dateValue.month.toString() +
                              "/" +
                              dateValue.year.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {});
                        },
                      )),
                      Text(
                        "Time",
                        style: TextStyle(
                            fontFamily: "Fenix-Regular",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                      ),
                      Container(
                          child: FlatButton(
                        child: Text(
                          timeValue.hour.toString() +
                              ":" +
                              dateValue.minute.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {});
                        },
                      )),
                      Text(
                        "Notification Type",
                        style: TextStyle(
                            fontFamily: "Fenix-Regular",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        height: 50,
                        child: DropdownButton(
                          isExpanded: true,
                          value: notifValue,
                          items: notifType.map((value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              notifValue = value;
                            });
                          },
                        ),
                      ),
                      Text(
                        "Notification Sound",
                        style: TextStyle(
                            fontFamily: "Fenix-Regular",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        height: 50,
                        child: DropdownButton(
                          isExpanded: true,
                          value: soundValue,
                          items: soundType.map((value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              soundValue = value;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment(0, 0.9),
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: Colors.red[700],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
