import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'calendar.dart';
import 'constant.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int last;
  @override
  void initState() {
    super.initState();
    Constant.readState().then((value) {
      last = value;
    });

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => (last == 0 ? Home() : Calendar())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Constant.background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Image(
                  image: AssetImage("assets/app_icon.png"),
                  height: 110,
                  width: 110,
                ),
              ),
              Text("ManagerKu", style: Constant.heading(fontSize: 25))
            ],
          ),
        ),
      ),
    );
  }
}
