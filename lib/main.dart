import 'package:flutter/material.dart';
import 'package:flutter_clock/pages/enums.dart';
import 'package:flutter_clock/pages/home_page.dart';
import 'package:flutter_clock/pages/menu_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "avenir",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:ChangeNotifierProvider<MenuInfo>(
      create: (context)=>MenuInfo(MenuType.clock),
      child: HomePage()) ,
    );
  }
}
