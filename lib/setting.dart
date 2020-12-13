import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class Setting extends StatefulWidget {
  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {
  String dropDownValue =
      Constant.hour12Format == true ? "12 Hour Format" : "24 Hour Format";
  List<String> dropDown = ["24 Hour Format", "12 Hour Format"];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: Scaffold(
        body: Container(
          color: Constant.grey,
          child: Column(
            children: [
              SafeArea(
                //judul dan tombol back
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        color: Constant.darkBlue,
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context, true);
                        }),
                    Text(
                      "Setting",
                      style: Constant.heading2(),
                    ),
                    Spacer()
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
              Expanded(
                child: Container(
                  decoration: Constant.bodyBackground(),
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      Text(
                        "Time Format",
                        style: Constant.heading(fontSize: 25),
                      ),
                      DropdownButton(
                          dropdownColor: Constant.grey,
                          isExpanded: true,
                          value: dropDownValue,
                          items: dropDown
                              .map((e) => DropdownMenuItem(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  value: e))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              dropDownValue = value;
                              Constant.hour12Format = (dropDownValue[0] == "1");
                            });
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
