import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Color darkOrange = Color(0xffFF7D45);
Color lightOrange = Color(0xffF9AE91);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Meeting> meetings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendar"),
          flexibleSpace: Container(
            decoration: BoxDecoration(color: darkOrange),
          ),
          leading: IconButton(
            icon: Icon(Icons.list),
            onPressed: () => print("List"),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.more_vert), onPressed: () => print("Option"))
          ],
        ),
        body: SfCalendar(
          view: CalendarView.month,
          todayHighlightColor: lightOrange,
          onTap: (calendarTapDetails) =>
              print(calendarTapDetails.appointments.asMap()),
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(
              showAgenda: true,
              agendaStyle: AgendaStyle(
                backgroundColor: darkOrange,
              ),
              monthCellStyle: MonthCellStyle(
                backgroundColor: lightOrange,
                todayBackgroundColor: darkOrange,
                trailingDatesBackgroundColor: Colors.grey,
                leadingDatesBackgroundColor: Colors.grey,
              )),
        ));
  }

  List<Meeting> _getDataSource() {
    meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('Conference', startTime, endTime, lightOrange, false));
    meetings.add(Meeting('Meet', startTime, endTime, lightOrange, false));
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
