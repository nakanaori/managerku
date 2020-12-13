import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'splash.dart';
import 'constant.dart';

void main() async {
  Constant.flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await Constant.flutterLocalNotificationPlugin.initialize(
      initializationSettings, onSelectNotification: (String payload) async {
    if (payload != null) {
      print('notification payload : ' + payload);
    }
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ManagerKu",
      home: Splash(),
    );
  }
}
