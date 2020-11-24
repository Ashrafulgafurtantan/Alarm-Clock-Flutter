
import 'package:flutter_clock/pages/alarm_info.dart';
import 'package:flutter_clock/pages/enums.dart';
import 'package:flutter_clock/pages/menu_info.dart';

List<MenuInfo> menuItems=[
  MenuInfo(MenuType.clock,image:'assets/images/clock_icon.png',title:'Clock' ),
  MenuInfo(MenuType.alarm,image:'assets/images/alarm_icon.png',title:'Alarm' ),
  MenuInfo(MenuType.timer,image:'assets/images/timer_icon.png',title:'Timer' ),
  MenuInfo(MenuType.stopwatch,image:'assets/images/stopwatch_icon.png',title:'StopWatch' ),

];

List<AlarmInfo> alarms=[
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(hours: 1)),id: 0,gradientColorIndex: 0,isPending: false,title: "Office",),
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(minutes: 20)),id: 1,gradientColorIndex: 1,isPending: false,title: "Sports",),
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(minutes: 30)),id: 2,gradientColorIndex: 2,isPending: false,title: "Lunch",),
];
List<int> idOccupiedLists=[0,1,2];
