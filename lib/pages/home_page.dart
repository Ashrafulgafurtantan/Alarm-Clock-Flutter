import 'package:flutter/material.dart';
import 'package:flutter_clock/widgets/clock_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Color(0xff2d2f41),
        child: ClockView(),
      ),
    );
  }
}
