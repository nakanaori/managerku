class Reminder {
  int _id;
  String _title;
  String _details;
  int _date;
  int _timeFrom;
  int _timeTo;

  int get id => this._id;
  String get title => this._title;
  String get details => this._details;
  int get date => this._date;
  int get timeFrom => this._timeFrom;
  int get timeTo => this._timeTo;

  set id(int id) => this._id = id;
  set title(String id) => this._title = title;
  set details(String details) => this._details = details;
  set date(int date) => this._date = date;
  set timeFrom(int timeFrom) => this._timeFrom = timeFrom;
  set timeTo(int timeTo) => this._timeTo = timeTo;

  Reminder(
      this._title, this._details, this._date, this._timeFrom, this._timeTo);

  Reminder.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._details = map['details'];
    this._date = map['date'];
    this._timeFrom = map['timeFrom'];
    this._timeTo = map['timeTo'];
  }

  String dateToString() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this._date);
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

  String timeFromToString() {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(this._timeFrom);
    return (time.hour >= 10
            ? time.hour.toString()
            : '0' + time.hour.toString()) +
        ':' +
        (time.minute >= 10
            ? time.minute.toString()
            : '0' + time.minute.toString());
  }

  String timeToToString() {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(this._timeTo);
    return (time.hour >= 10
            ? time.hour.toString()
            : '0' + time.hour.toString()) +
        ':' +
        (time.minute >= 10
            ? time.minute.toString()
            : '0' + time.minute.toString());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['title'] = this._title;
    map['details'] = this._details;
    map['date'] = this._date;
    map['timeFrom'] = this._timeFrom;
    map['timeTo'] = this._timeTo;
    return map;
  }
}
