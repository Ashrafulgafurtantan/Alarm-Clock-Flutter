import 'package:flutter/cupertino.dart';
import 'package:flutter_clock/pages/enums.dart';

class MenuInfo extends ChangeNotifier{
  MenuType menuType;
  String title,image;

  MenuInfo(this.menuType,{this.title,this.image});

  updateMenu(MenuInfo menuInfo){
    this.menuType=menuInfo.menuType;
    this.title = menuInfo.title;
    this.image = menuInfo.image;
    notifyListeners();
  }
}