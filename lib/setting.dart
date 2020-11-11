import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting>{
  String dropdownValue = "24 hours";
  Color darkOrange = Color(0xffFF7D45);
  Color lightOrange = Color(0xffF9AE91);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Setting"),
          flexibleSpace: Container(
            decoration: BoxDecoration(color: darkOrange),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => print("Back"),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: lightOrange,
              ),
            ),
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                      "Time Format",
                      style: TextStyle(
                        fontSize: 18,
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    isExpanded: true,
                    value: dropdownValue,
                    onChanged: (String newValue){
                      setState((){
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>["24 hours", "12 hours"].
                    map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ]
            )
          ]
        )
      ),
    );
  }
}
