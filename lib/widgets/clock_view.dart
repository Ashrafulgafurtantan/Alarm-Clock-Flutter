import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1),(timer){
      setState(() {

      });
    });
      super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: - pi/2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}
class ClockPainter extends CustomPainter{

  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    final centerX=size.width/2.0;
    final centerY=size.height/2.0;
    final center = Offset(centerX,centerY);
    var radius = min(centerX,centerY);
    //------------------------------------------
    var fillBrush = Paint()
    ..color=Color(0xff444974);
    canvas.drawCircle(center, radius-40, fillBrush);
    var outlineBrush = Paint()
      ..color=Color(0xffeaecff)
      ..style=PaintingStyle.stroke
      ..strokeWidth=16;
    canvas.drawCircle(center, radius-40, outlineBrush);
    var centerDotBrush = Paint()
      ..color=Color(0xffeaecff);

    var secondBrush = Paint()
      ..color=Colors.orange[300]
      ..style=PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth=8;

    var minuteBrush = Paint()
      ..shader=RadialGradient(colors: [Colors.blueAccent,Colors.amber ])//[Color(0xff748ef6),Color(0xff77ddff)]
      .createShader(Rect.fromCircle(center: center,radius: radius))
      ..style=PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth=12;

    var hourBrush = Paint()
      ..shader=RadialGradient(colors: [Color(0xffea74ab),Color(0xff77ddff)])
          .createShader(Rect.fromCircle(center: center,radius: radius))
      ..style=PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth=16;

   //clock pristhotol



    var hourHandX = centerX+60*cos((dateTime.hour*30+dateTime.minute*0.5)*pi/180.0);
    var hourHandY = centerY +60* sin((dateTime.hour*30+dateTime.minute*0.5)*pi/180.0);
    canvas.drawLine(center,Offset(hourHandX, hourHandY), hourBrush);



    var minHandX = centerX+80*cos(dateTime.minute*6*pi/180.0);
    var minHandY = centerY +80* sin(dateTime.minute*6*pi/180.0);
    canvas.drawLine(center,Offset(minHandX, minHandY), minuteBrush);




    var secHandX = centerX+80*cos(dateTime.second*6*pi/180.0);
    var secHandY = centerY +80* sin(dateTime.second*6*pi/180.0);
    canvas.drawLine(center,Offset(secHandX, secHandY), secondBrush);

    canvas.drawCircle(center, 16, centerDotBrush);


  }

  @override
  bool shouldRepaint( CustomPainter oldDelegate) {
    return true;
  }

}