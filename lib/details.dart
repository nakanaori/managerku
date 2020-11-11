import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  showAlertDialog(BuildContext context) {
    Widget noButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () => Navigator.pop(context),
    );
    Widget yesButton = FlatButton(
      child: Text("Yes", style: TextStyle(fontSize: 15)),
      onPressed: () {},
    );

    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text(
        "Are you sure you want to delete this reminder?",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color darkOrange = Color(0xffFF7D45);
    Color lightOrange = Color(0xffF9AE91);
    return Scaffold(
        appBar: AppBar(
          title: Text("Reminder Detail"),
          flexibleSpace: Container(
            decoration: BoxDecoration(color: darkOrange),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => print("Back"),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.more_vert), onPressed: () => print("Option"))
          ],
        ),
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(color: lightOrange),
          ),
          Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Monday, 23 September 2020",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "23.00 - 15.00",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Container(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Reminder Name :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Reminder Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Reminder Detail :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Detail dari Reminder",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(0.9, 0.9),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () => print("Edit"),
                      color: darkOrange,
                      child: Text(
                        "Edit",
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () => showAlertDialog(context),
                      color: darkOrange,
                      child: Text("Delete",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
