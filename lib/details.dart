import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'constant.dart';
import 'crud.dart';
import 'edit.dart';
import 'reminder.dart';
import 'setting.dart';

class Details extends StatefulWidget {
  final Reminder reminder;
  Details(this.reminder);
  @override
  _DetailsState createState() => _DetailsState(reminder);
}

class _DetailsState extends State<Details> {
  bool isEdited = false;
  CRUD dbhelper = CRUD();
  Reminder reminder;
  _DetailsState(this.reminder);

  void scheduleAlarm(int id, Reminder reminder, DateTime time) async {
    List<PendingNotificationRequest> list = await Constant
        .flutterLocalNotificationPlugin
        .pendingNotificationRequests();
    for (PendingNotificationRequest i in list) {
      if (i.id == id) {
        await Constant.flutterLocalNotificationPlugin.cancel(id);
        break;
      }
    }
    var androidPlatformChannelSpecifications = AndroidNotificationDetails(
        'Channel_ID', 'Channel_title', 'Channel details',
        priority: Priority.high, importance: Importance.max, ticker: 'test');

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifications);

    await Constant.flutterLocalNotificationPlugin
        .schedule(id, reminder.title, "", time, platformChannelSpecifics);
  }

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
      onPressed: () async {
        Navigator.pop(context);

        int res = await dbhelper.delete(this.reminder);
        if (res != 0) {
          isEdited = true;
          Navigator.pop(context, isEdited);
        }
      },
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

  Future<Reminder> navigateToEntryForm(
      BuildContext context, Reminder input) async {
    var res = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Edit(input)));
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context, isEdited);
                      }),
                  Text(
                    "Details",
                    style: Constant.heading2(),
                  ),
                  IconButton(
                      color: Constant.darkBlue,
                      icon: Icon(Icons.settings, size: 30),
                      onPressed: () {
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (_) => Setting()));
                      })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
            ),
            Expanded(
              child: Container(
                decoration: Constant.bodyBackground(),
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Center(
                        child: Text(
                      reminder.title,
                      style: Constant.heading(fontSize: 30),
                      textAlign: TextAlign.center,
                    )),
                    Center(
                        child: Text(
                      reminder.details,
                      style: TextStyle(
                        color: Constant.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Date",
                        style: Constant.heading(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                            Constant.dateToString(
                                DateTime.fromMillisecondsSinceEpoch(
                                    reminder.dateFrom)),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 2, color: Constant.gold),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:
                          Text("Time", style: Constant.heading(fontSize: 20)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150,
                          height: 40,
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Center(
                              child: Text(
                            Constant.timeToString(
                                DateTime.fromMillisecondsSinceEpoch(
                                    reminder.dateFrom)),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border:
                                  Border.all(width: 2, color: Constant.gold),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Text(
                          "-",
                          style: Constant.heading(fontSize: 20),
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Center(
                              child: Text(
                            Constant.timeToString(
                                DateTime.fromMillisecondsSinceEpoch(
                                    reminder.dateTo)),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border:
                                  Border.all(width: 2, color: Constant.gold),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Notification",
                        style: Constant.heading(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Has Notification : ",
                                style: Constant.heading(fontSize: 17),
                              ),
                              Text(
                                reminder.hasNotificationBool().toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notification Time : ",
                                style: Constant.heading(fontSize: 17),
                              ),
                              Flexible(
                                child: Text(
                                  (reminder.hasNotificationBool() == false
                                      ? "Disable"
                                      : reminder.notificationTime),
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 2, color: Constant.gold),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    //Edit and delete button
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                var editedReminder = await navigateToEntryForm(
                                    context, this.reminder);
                                if (editedReminder != null) {
                                  int res =
                                      await dbhelper.update(editedReminder);
                                  if (editedReminder.hasNotificationBool()) {
                                    scheduleAlarm(
                                        res,
                                        editedReminder,
                                        DateTime.fromMillisecondsSinceEpoch(
                                                editedReminder.dateFrom)
                                            .subtract(Constant.getDuration(
                                                editedReminder
                                                    .notificationTime)));
                                  }

                                  if (res != null) {
                                    isEdited = true;
                                    setState(() {
                                      this.reminder = editedReminder;
                                    });
                                  }
                                }
                              },
                              child: Ink(
                                width: 100,
                                height: 40,
                                decoration: Constant.buttonBackground,
                                child: Center(
                                    child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Constant.darkBlue, fontSize: 20),
                                )),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                showAlertDialog(context);
                              },
                              child: Ink(
                                width: 100,
                                height: 40,
                                decoration: Constant.buttonBackground,
                                child: Center(
                                    child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: Constant.darkBlue, fontSize: 20),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
