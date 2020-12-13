class Reminder {
  int _id;
  String _title;
  String _details;
  int _dateFrom;
  int _dateTo;
  int _hasNotification;
  String _notificationTime;

  int get id => this._id;
  String get title => this._title;
  String get details => this._details;
  int get dateFrom => this._dateFrom;
  int get dateTo => this._dateTo;
  int get hasNotification => this._hasNotification;
  String get notificationTime => this._notificationTime;

  set notificationTime(String time) {
    this._notificationTime = time;
  }

  set id(int id) {
    this._id = id;
  }

  set title(String title) {
    this._title = title;
  }

  set details(String details) {
    this._details = details;
  }

  set dateFrom(int dateFrom) {
    this._dateFrom = dateFrom;
  }

  set dateTo(int dateTo) {
    this._dateTo = dateTo;
  }

  set hasNotification(int hasNotification) {
    this._hasNotification = hasNotification;
  }

  Reminder(this._title, this._details, this._dateFrom, this._dateTo,
      this._hasNotification, this._notificationTime);

  Reminder.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._details = map['details'];
    this._dateFrom = map['dateFrom'];
    this._dateTo = map['dateTo'];
    this._hasNotification = map['hasNotification'];
    this._notificationTime = map['notificationTime'];
  }

  bool hasNotificationBool() {
    return this._hasNotification == 0 ? false : true;
  }

  String dateToString(String tell) {
    DateTime date;
    if (tell == 'from')
      date = DateTime.fromMillisecondsSinceEpoch(this._dateFrom);
    else
      date = DateTime.fromMillisecondsSinceEpoch(this._dateTo);
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

  String timeToString(String tell) {
    DateTime time;
    if (tell == 'from')
      time = DateTime.fromMillisecondsSinceEpoch(this._dateFrom);
    else
      time = DateTime.fromMillisecondsSinceEpoch(this._dateTo);
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
    map['dateFrom'] = this._dateFrom;
    map['dateTo'] = this._dateTo;
    map['hasNotification'] = this._hasNotification;
    map['notificationTime'] = this._notificationTime;
    return map;
  }
}
