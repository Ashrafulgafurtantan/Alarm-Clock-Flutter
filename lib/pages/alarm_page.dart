import 'package:flutter/material.dart';
import 'package:flutter_clock/pages/alarm_info.dart';
import 'package:flutter_clock/pages/constants.dart';
import 'package:flutter_clock/pages/data.dart';
import 'package:flutter_clock/pages/local_notification_manager.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime _alarmTime;
  String _alarmTimeString;



  @override
  void initState() {
    _alarmTime = DateTime.now();
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }
  onNotificationReceive(ReceiveNotification notification){
    print("Notification Received: $notification ${DateTime.now()}");
  }
  onNotificationClick(String payload){
    print("Payload = $payload");
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AlarmPage()));
  }

  removeNotification(int id)async{
    await localNotifyManager.cancelNotification(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Alarm',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24),
          ),
          Expanded(
              child:  ListView(
                  children:alarms.map((alarm){
                    switchValueChange(bool newVal)async{
                      if(newVal){
                        await localNotifyManager.scheduledNotification(scheduleTime: alarm.alarmDateTime,
                            body: 'Good morning! Time for office.',title: alarm.title,id: alarm.id);
                      }else
                          removeNotification(alarm.id);

                      setState(() {
                        alarm.isPending=newVal;
                      });
                      print(alarm.toString());
                    }

                    var alarmTime =DateFormat('hh:mm aa').format(alarm.alarmDateTime);
                    var gradientColor = GradientTemplate
                        .gradientTemplate[alarm.gradientColorIndex].colors;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColor,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
//                        boxShadow: [
//                          BoxShadow(
//                            color: gradientColor.last.withOpacity(0.4),
//                            blurRadius: 8,
//                            spreadRadius: 1,
//                            offset: Offset(0, 6),
//                          ),
//                        ],
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.label,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    alarm.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  ),
                                ],
                              ),
                              Switch(
                                onChanged: switchValueChange,
                                value: alarm.isPending,
                                activeColor: Colors.white,
                                inactiveThumbColor: Colors.grey,
                              ),
                            ],
                          ),
                          Text(
                            'Mon-Fri',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'avenir'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                alarmTime,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'avenir',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.white,
                                onPressed: () {
                                  int deletedId = alarm.id;
                                  idOccupiedLists.remove(deletedId);
                                  removeNotification(deletedId);
                                  setState(() {
                                    alarms.remove(alarm);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }) .followedBy([
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          _alarmTimeString =
                              DateFormat('HH:mm').format(DateTime.now());
                          showModalBottomSheet(
                            useRootNavigator: true,
                            context: context,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setModalState) {
                                  return Container(
                                    padding: const EdgeInsets.all(32),
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          onPressed: () async {
                                            var selectedTime =
                                            await showTimePicker(
                                              context: context,
                                              initialTime:
                                              TimeOfDay.now(),
                                            );
                                            if (selectedTime != null) {
                                              final now = DateTime.now();
                                              var selectedDateTime =
                                              DateTime(
                                                  now.year,
                                                  now.month,
                                                  now.day,
                                                  selectedTime.hour,
                                                  selectedTime
                                                      .minute);
                                              _alarmTime =
                                                  selectedDateTime;
                                              setModalState(() {
                                                _alarmTimeString =
                                                    selectedTime
                                                        .toString();
                                              });
                                            }
                                          },
                                          child: Text(
                                            _alarmTimeString,
                                            style:
                                            TextStyle(fontSize: 32),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text('Repeat'),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios),
                                        ),
                                        ListTile(
                                          title: Text('Sound'),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios),
                                        ),
                                        ListTile(
                                          title: Text('Title'),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios),
                                        ),
                                        FloatingActionButton.extended(
                                          onPressed: () async {
                                            DateTime scheduleAlarmDateTime;
                                            if (_alarmTime
                                                .isAfter(DateTime.now()))
                                              scheduleAlarmDateTime =
                                                  _alarmTime;
                                            else
                                              scheduleAlarmDateTime =
                                                  _alarmTime.add(
                                                      Duration(days: 1));

                                            print(scheduleAlarmDateTime);
                                            //...........
                                            int newId;
                                            for(var i=0;i<=idOccupiedLists.length;i++){
                                              if(!idOccupiedLists.contains(i)){
                                                newId=i;
                                                break;
                                              }
                                            }
                                            setState(() {
                                              alarms.add(AlarmInfo(isPending: true,alarmDateTime: scheduleAlarmDateTime,
                                                  title: "New Task",gradientColorIndex:(newId%7) ,id:newId));
                                              idOccupiedLists.add(newId);
                                            });
                                            alarms.forEach((element) {
                                              print(element.toString());
                                            });
                                            await localNotifyManager.scheduledNotification(scheduleTime: scheduleAlarmDateTime,
                                                body: 'Good morning! Time for office.',title: "New Task",id: newId);
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.alarm),
                                          label: Text('Save'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                          // scheduleAlarm();
                        },
                        child: Image.asset(
                          'assets/images/add_alarm.png',
                          scale: 1.5,
                        ),
                      ),
                    ),
                  ]).toList())
          ),
        ],
      ),
    );
  }

}
