import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'constant.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'reminder.dart';

class Edit extends StatefulWidget {
  Reminder reminder;
  Edit(this.reminder);
  @override
  _EditState createState() => _EditState(reminder);
}

class _EditState extends State<Edit> {
  Reminder reminder;
  _EditState(this.reminder);
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  DateTime timeFrom;
  DateTime timeTo;
  DateTime date;
  bool hasNotification = false;
  String notifValue = "No Notification";
  List<String> notifType = ["No Notification", "Use Notification"];
  String notifTimeValue = "5 minutes before scheduled";
  List<String> notifTime = [
    "5 minutes before scheduled",
    "10 minutes before scheduled",
    "30 minutes before scheduled",
    "1 hour before scheduled",
    "3 hours before scheduled",
    "6 hours before scheduled",
    "12 hours before scheduled",
    "1 day before scheduled",
    "3 days before scheduled"
  ];
  String head = "ADD";
  bool inserted = false;

  @override
  Widget build(BuildContext context) {
    if (reminder != null && !inserted) {
      titleCtrl.text = reminder.title;
      descCtrl.text = (reminder.details == null ? "" : reminder.details);
      date = DateTime.fromMillisecondsSinceEpoch(reminder.dateFrom);
      dateCtrl.text = Constant.dateToString(date);
      timeFrom = DateTime.fromMillisecondsSinceEpoch(reminder.dateFrom);
      timeTo = DateTime.fromMillisecondsSinceEpoch(reminder.dateTo);
      hasNotification = reminder.hasNotificationBool();
      notifValue = hasNotification ? "Use Notification" : "No Notification";
      notifTimeValue = reminder.notificationTime;
      head = "EDIT";
      inserted = true;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Constant.grey,
        body: Column(
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
                        Navigator.pop(context);
                      }),
                  Text(
                    head + " REMINDER",
                    style: Constant.heading2(),
                  ),
                  Spacer()
                ],
              ),
            ),
            Padding(
              //kasih jarak antara judul sama yang bawah
              padding: EdgeInsets.all(20),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: Constant.bodyBackground(),
                child: ListView(
                  children: [
                    //Judul Reminder
                    Text("Title", style: Constant.heading(fontSize: 18)),
                    TextField(
                        controller: titleCtrl,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Constant.gold,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constant.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constant.grey)))),
                    //Deskripsi Reminder
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Description",
                          style: Constant.heading(fontSize: 18)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      height: 170,
                      child: TextField(
                        controller: descCtrl,
                        cursorColor: Constant.gold,
                        style: TextStyle(color: Colors.white),
                        maxLength: 1000,
                        maxLines: 12,
                        decoration: InputDecoration(
                            counterStyle: Constant.heading(fontSize: 10),
                            fillColor: Colors.grey,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),

                    //Tanggal Reminder
                    Text("Date", style: Constant.heading(fontSize: 18)),
                    TextField(
                        controller: dateCtrl,
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            onConfirm: (time) {
                              dateCtrl.text = Constant.dateToString(time);
                              date = time;
                            },
                          );
                        },
                        readOnly: true,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Constant.gold,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constant.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constant.grey)))),

                    //waktu reminder
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child:
                          Text("Time", style: Constant.heading(fontSize: 18)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Time From
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: InkWell(
                            radius: 10,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            splashColor: Constant.gold,
                            onTap: () {
                              print(Constant.hour12Format);
                              if (Constant.hour12Format) {
                                DatePicker.showTimePicker(
                                  context,
                                  showSecondsColumn: false,
                                  onConfirm: (time) {
                                    setState(() {
                                      timeFrom = time;
                                      if (timeTo == null) timeTo = time;
                                    });
                                  },
                                );
                              } else {
                                DatePicker.showTime12hPicker(
                                  context,
                                  onConfirm: (time) {
                                    setState(() {
                                      timeFrom = time;
                                      if (timeTo == null) timeTo = time;
                                      if (timeTo.isBefore(timeFrom))
                                        timeTo = time;
                                    });
                                  },
                                );
                              }
                            },
                            child: Ink(
                              width: 150,
                              height: 40,
                              child: Center(
                                  child: Text(
                                (timeFrom == null
                                    ? "00 : 00"
                                    : Constant.timeToString(timeFrom)),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Constant.gold),
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                        //Pemisah
                        Text(
                          "-",
                          style: TextStyle(color: Constant.grey, fontSize: 25),
                        ),

                        //Time To
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: InkWell(
                            radius: 10,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            splashColor: Constant.gold,
                            onTap: () {
                              print(Constant.hour12Format);
                              if (Constant.hour12Format) {
                                DatePicker.showTimePicker(
                                  context,
                                  showSecondsColumn: false,
                                  onConfirm: (time) {
                                    setState(() {
                                      timeTo = time;
                                    });
                                  },
                                );
                              } else {
                                DatePicker.showTime12hPicker(
                                  context,
                                  onConfirm: (time) {
                                    setState(() {
                                      timeTo = time;
                                    });
                                  },
                                );
                              }
                            },
                            child: Ink(
                              width: 150,
                              height: 40,
                              child: Center(
                                  child: Text(
                                (timeFrom == null
                                    ? "00 : 00"
                                    : Constant.timeToString(timeTo)),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Constant.gold),
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Notification
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Notification",
                          style: Constant.heading(fontSize: 18)),
                    ),
                    DropdownButton(
                        isExpanded: true,
                        dropdownColor: Constant.grey,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        value: notifValue,
                        items: notifType
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != "No Notification") {
                            hasNotification = true;
                          } else {
                            hasNotification = false;
                          }
                          setState(() {
                            notifValue = value;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Notification Time",
                        style: Constant.heading(fontSize: 18),
                      ),
                    ),
                    //Waktu Notification
                    DropdownButton(
                        disabledHint: Text("Disable",
                            style:
                                TextStyle(color: Constant.grey, fontSize: 16)),
                        isExpanded: true,
                        dropdownColor: Constant.grey,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        value: notifTimeValue,
                        items: notifTime
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (hasNotification == false
                            ? null
                            : (value) {
                                notifValue = value;
                              })),
                    //Button
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Save Button
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: InkWell(
                              radius: 10,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              splashColor: Constant.gold,
                              onTap: () {
                                if (titleCtrl.text.trim().isEmpty ||
                                    titleCtrl.text == "") {
                                  //Gk ada title
                                  Constant.showAlertDialog(
                                      context, "Title can't be empty");
                                } else if (dateCtrl.text.trim().isEmpty ||
                                    dateCtrl.text == "") {
                                  //Gk ada tanggal
                                  Constant.showAlertDialog(
                                      context, "Date can't be empty");
                                } else if (timeFrom == null) {
                                  //Gk ada waktu jadwal
                                  Constant.showAlertDialog(
                                      context, "Time can't be empty");
                                } else {
                                  DateTime scheduleFrom = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      timeFrom.hour,
                                      timeFrom.minute);
                                  DateTime scheduleTo = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      timeTo.hour,
                                      timeTo.minute);
                                  DateTime notifSchedule = scheduleFrom;
                                  if (hasNotification) {
                                    Duration dur =
                                        Constant.getDuration(notifTimeValue);
                                    notifSchedule.subtract(dur);
                                    if (notifSchedule
                                        .isBefore(DateTime.now())) {
                                      Constant.showAlertDialog(context,
                                          "Can't create a notification in the past!");
                                    }
                                  }
                                  if (scheduleFrom.isBefore(DateTime.now())) {
                                    //Jika jadwal yang dibuat tuh kemarin"
                                    Constant.showAlertDialog(context,
                                        "Can't create a reminder for the past!");
                                  } else if (scheduleFrom.isAfter(scheduleTo)) {
                                    //Jika jadwal kiri after jadwal kanan
                                    Constant.showAlertDialog(context,
                                        "Can't create a reminder that ends at the past!");
                                  } else {
                                    //ini baru smua validated
                                    if (this.reminder == null) {
                                      this.reminder = Reminder(
                                          titleCtrl.text,
                                          descCtrl.text,
                                          scheduleFrom.millisecondsSinceEpoch,
                                          scheduleTo.millisecondsSinceEpoch,
                                          (hasNotification == true ? 1 : 0),
                                          notifTimeValue);
                                    } else {
                                      this.reminder.title = titleCtrl.text;
                                      this.reminder.details = descCtrl.text;
                                      this.reminder.dateFrom =
                                          scheduleFrom.millisecondsSinceEpoch;
                                      this.reminder.dateTo =
                                          scheduleTo.millisecondsSinceEpoch;
                                      this.reminder.hasNotification =
                                          (hasNotification == true ? 1 : 0);
                                      this.reminder.notificationTime =
                                          notifTimeValue;
                                    }

                                    Navigator.pop(context, reminder);
                                  }
                                }
                              },
                              child: Ink(
                                width: 100,
                                height: 40,
                                child: Center(
                                    child: Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Constant.darkBlue, fontSize: 20),
                                )),
                                decoration: Constant.buttonBackground,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
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
