import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:managerku/reminder.dart';

import 'constant.dart';
import 'crud.dart';
import 'details.dart';
import 'edit.dart';
import 'calendar.dart';
import 'setting.dart';

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
    Constant.saveState(0);
  }

  void updateListView() {
    setState(() {
      future = dbhelper.getReminder();
    });
  }

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
        priority: Priority.high,
        importance: Importance.max,
        ticker: 'test',
        fullScreenIntent: true,
        enableVibration: true,
        visibility: NotificationVisibility.public,
        playSound: true);

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifications);

    await Constant.flutterLocalNotificationPlugin
        .schedule(id, reminder.title, "", time, platformChannelSpecifics);
  }

  Future<Reminder> navigateToEntryForm(
      BuildContext context, Reminder input) async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Edit(input, null)));
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Constant.background,
        child: Center(
          child: Column(
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        color: Constant.gold,
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (_) => Calendar()));
                        }),
                    Text(
                      "LIST",
                      style: Constant.heading(fontSize: 25),
                    ),
                    IconButton(
                      color: Constant.gold,
                      icon: Icon(Icons.settings),
                      onPressed: () async {
                        var refresh = await Navigator.push(context,
                            new MaterialPageRoute(builder: (_) => Setting()));
                        if (refresh) {
                          updateListView();
                        }
                      },
                    )
                  ],
                ),
              ),
              FutureBuilder<List<Reminder>>(
                future: future,
                builder: (context, snapshot) {
                  List<String> date = [];
                  Map<String, List<Reminder>> data = Map();
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    for (Reminder reminder in snapshot.data) {
                      String thisDate = reminder.dateToString('from');
                      if (date.contains(thisDate) == false) date.add(thisDate);
                      if (data[thisDate] == null) data[thisDate] = List();
                      data[thisDate].add(reminder);
                    }
                    return Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        children: date
                            .map((value) => createCard(value, data))
                            .toList(),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Center(
                          child: Text("No Reminder",
                              style: TextStyle(
                                  color: Constant.gold,
                                  fontFamily: "Poppins",
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    Shadow(color: Colors.black, blurRadius: 10)
                                  ]))),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var reminder = await navigateToEntryForm(context, null);
          if (reminder != null) {
            int res = await dbhelper.insert(reminder);
            if (reminder.hasNotificationBool()) {
              scheduleAlarm(
                  res,
                  reminder,
                  DateTime.fromMillisecondsSinceEpoch(reminder.dateFrom)
                      .subtract(
                          Constant.getDuration(reminder.notificationTime)));
            }
            if (res != 0) {
              updateListView();
            }
          }
        },
        backgroundColor: Constant.gold,
        foregroundColor: Constant.darkBlue,
        splashColor: Constant.darkBlue,
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  Container createCard(String value, Map<String, List<Reminder>> data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Center(child: Text(value, style: Constant.heading(fontSize: 20))),
          Column(
            children: createData(data[value]),
          ),
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

  Padding createRow(Reminder reminder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            // print(reminder.title);
            var res = await Navigator.push(context,
                new MaterialPageRoute(builder: (_) => Details(reminder)));
            if (res) {
              updateListView();
            }
          },
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Constant.grey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(reminder.title,
                      style: TextStyle(
                          fontSize: 22,
                          color: Constant.darkBlue,
                          fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    Constant.timeToString(DateTime.fromMillisecondsSinceEpoch(
                            reminder.dateFrom)) +
                        (reminder.dateFrom == reminder.dateTo
                            ? ""
                            : " - " +
                                Constant.timeToString(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        reminder.dateTo))),
                    style: TextStyle(
                      fontSize: 17,
                      color: Constant.darkBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
