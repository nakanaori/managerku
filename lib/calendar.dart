import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'constant.dart';
import 'crud.dart';
import 'details.dart';
import 'edit.dart';
import 'home.dart';
import 'reminder.dart';
import 'setting.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Calendar> {
  CRUD dbhelper = CRUD();
  List<Reminder> future;
  CalendarController controller = CalendarController();
  @override
  void initState() {
    super.initState();
    updateListView();
    Constant.saveState(1);
  }

  Future<Reminder> navigateToEntryForm(
      BuildContext context, Reminder input) async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                Edit(input, controller.selectedDate)));
    return res;
  }

  void updateListView() async {
    future = await dbhelper.getReminder();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Constant.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      color: Constant.gold,
                      icon: Icon(Icons.list),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            new MaterialPageRoute(builder: (_) => Home()));
                      }),
                  Text(
                    "Calendar",
                    style: Constant.heading(fontSize: 25),
                  ),
                  IconButton(
                    color: Constant.gold,
                    icon: Icon(Icons.settings),
                    onPressed: () async {
                      await Navigator.push(context,
                              new MaterialPageRoute(builder: (_) => Setting()))
                          .then((_) {
                        setState(() {});
                      });
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: SfCalendar(
                controller: controller,
                onTap: (calendarTapDetails) async {
                  if (calendarTapDetails.targetElement ==
                      CalendarElement.appointment) {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Details(
                                calendarTapDetails.appointments[0]))).then((_) {
                      updateListView();
                    });
                  }
                },
                cellBorderColor: Colors.transparent,
                selectionDecoration: BoxDecoration(
                    border: Border.all(width: 2, color: Constant.gold)),
                view: CalendarView.month,
                todayHighlightColor: Constant.gradientFrom,
                todayTextStyle: Constant.heading(fontSize: 15),
                backgroundColor: Colors.transparent,
                headerStyle: CalendarHeaderStyle(
                    textStyle: Constant.heading(fontSize: 20),
                    textAlign: TextAlign.center),
                viewHeaderStyle: ViewHeaderStyle(
                    dayTextStyle: Constant.heading(fontSize: 15),
                    dateTextStyle: Constant.heading(fontSize: 15)),
                dataSource: ReminderDataSource(future),
                appointmentTimeTextFormat:
                    (Constant.hour12Format ? "hh:mm a" : "HH:mm"),
                monthViewSettings: MonthViewSettings(
                    appointmentDisplayCount: 1,
                    showAgenda: true,
                    agendaStyle: AgendaStyle(
                        backgroundColor: Colors.transparent,
                        appointmentTextStyle:
                            TextStyle(color: Constant.darkBlue, fontSize: 18),
                        dayTextStyle:
                            TextStyle(color: Constant.gold, fontSize: 18),
                        dateTextStyle:
                            TextStyle(color: Constant.gold, fontSize: 18)),
                    monthCellStyle: MonthCellStyle(
                      backgroundColor: Colors.transparent,
                      todayBackgroundColor: Colors.transparent,
                      trailingDatesBackgroundColor: Colors.transparent,
                      leadingDatesBackgroundColor: Colors.transparent,
                      textStyle: Constant.heading(fontSize: 18),
                      leadingDatesTextStyle:
                          TextStyle(color: Constant.grey, fontSize: 15),
                      trailingDatesTextStyle:
                          TextStyle(color: Constant.grey, fontSize: 15),
                    )),
                allowViewNavigation: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: FloatingActionButton(
              heroTag: "Today",
              onPressed: () {
                setState(() {
                  controller.displayDate = DateTime.now();
                  controller.selectedDate = DateTime.now();
                });
              },
              backgroundColor: Constant.gold,
              foregroundColor: Constant.darkBlue,
              splashColor: Constant.darkBlue,
              child: Text(
                DateTime.now().day.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: "Add",
            onPressed: () async {
              print(controller.selectedDate.toString());
              var reminder = await navigateToEntryForm(context, null);
              if (reminder != null) {
                int res = await dbhelper.insert(reminder);
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
        ],
      ),
    );
  }
}

class ReminderDataSource extends CalendarDataSource {
  ReminderDataSource(List<Reminder> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.fromMillisecondsSinceEpoch(appointments[index].dateFrom);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.fromMillisecondsSinceEpoch(appointments[index].dateTo);
  }

  @override
  String getSubject(int index) {
    return appointments[index].title;
  }

  @override
  Color getColor(int index) {
    return Constant.grey;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
