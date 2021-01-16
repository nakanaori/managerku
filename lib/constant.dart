import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'reminder.dart';

class Constant {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;
  static bool hour12Format = false;
  static final Color grey = Color(0xffACB3B8);
  static final Color gold = Color(0xffE1DC64);
  static final Color darkBlue = Color(0xff273748);
  static final Color gradientTo = Color(0xff292323);
  static final Color gradientFrom = Color(0xff5A5C5F);
  static final BoxDecoration background = BoxDecoration(
      gradient: LinearGradient(
          colors: [gradientFrom, gradientTo],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));
  static TextStyle heading({double fontSize = 10}) {
    return TextStyle(
        fontFamily: "Poppins",
        fontSize: fontSize,
        color: gold,
        fontWeight: FontWeight.w700);
  }

  static final BoxDecoration buttonBackground = BoxDecoration(
      gradient: LinearGradient(
          colors: [gold, grey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight),
      borderRadius: BorderRadius.all(Radius.circular(20)));

  static TextStyle heading2() {
    return TextStyle(
        fontFamily: "Poppins",
        fontSize: 25,
        color: darkBlue,
        fontWeight: FontWeight.w700);
  }

  static void saveState(int location) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("Last", location);
  }

  static Future<int> readState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("Last") ?? 0;
  }

  static String timeToString(DateTime time) {
    if (!hour12Format) {
      return (time.hour < 10 ? "0" : "") +
          time.hour.toString() +
          " : " +
          (time.minute < 10 ? "0" : "") +
          time.minute.toString();
    } else {
      return (time.hour == 12
              ? "12"
              : (time.hour == 0
                  ? "12"
                  : (time.hour < 10
                      ? "0"
                      : (time.hour < 12
                          ? ""
                          : (time.hour % 12 < 10 ? "0" : ""))))) +
          (time.hour == 12
              ? ""
              : (time.hour == 0 ? "" : (time.hour % 12).toString())) +
          " : " +
          (time.minute < 10 ? "0" : "") +
          time.minute.toString() +
          (time.hour >= 12 ? " PM" : " AM");
    }
  }

  static String dateToString(DateTime date) {
    const dayString = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    const monthString = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return dayString[date.weekday] +
        ', ' +
        date.day.toString() +
        ' ' +
        monthString[date.month] +
        ' ' +
        date.year.toString();
  }

  static showAlertDialog(BuildContext context, String message) {
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () => Navigator.pop(context),
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      actions: [
        okButton,
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

  static BoxDecoration bodyBackground() => BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        gradient: LinearGradient(
            colors: [gradientFrom, gradientTo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      );

  static Duration getDuration(String notifTimeValue) {
    if (notifTimeValue == "5 minutes before scheduled") {
      return Duration(minutes: 5);
    } else if (notifTimeValue == "10 minutes before scheduled") {
      return Duration(minutes: 10);
    } else if (notifTimeValue == "30 minutes before scheduled") {
      return Duration(minutes: 30);
    } else if (notifTimeValue == "1 hour before scheduled") {
      return Duration(hours: 1);
    } else if (notifTimeValue == "3 hours before scheduled") {
      return Duration(hours: 3);
    } else if (notifTimeValue == "6 hours before scheduled") {
      return Duration(hours: 6);
    } else if (notifTimeValue == "12 hours before scheduled") {
      return Duration(hours: 12);
    } else if (notifTimeValue == "1 day before scheduled") {
      return Duration(days: 1);
    } else {
      return Duration(days: 3);
    }
  }

  static scheduleAlarm(int id, Reminder reminder, DateTime time) async {
    List<PendingNotificationRequest> list =
        await flutterLocalNotificationPlugin.pendingNotificationRequests();
    for (PendingNotificationRequest i in list) {
      if (i.id == id) {
        await flutterLocalNotificationPlugin.cancel(id);
        break;
      }
    }
    var androidPlatformChannelSpecifications = AndroidNotificationDetails(
        'Channel_ID', 'Channel_title', 'Channel details',
        priority: Priority.max,
        importance: Importance.max,
        ticker: 'test',
        fullScreenIntent: true,
        enableVibration: true,
        icon: 'notif',
        visibility: NotificationVisibility.public,
        sound: RawResourceAndroidNotificationSound("notif_sound"),
        playSound: true);

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifications);

    await flutterLocalNotificationPlugin.schedule(
        id, reminder.title, reminder.details, time, platformChannelSpecifics);
  }
}
