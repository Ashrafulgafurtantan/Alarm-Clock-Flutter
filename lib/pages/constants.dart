import 'package:flutter/material.dart';

class CustomColors {
  static Color primaryTextColor = Colors.white;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor = Color(0xFF2D2F41);
  static Color menuBackgroundColor = Color(0xFF242634);

  static Color clockBG = Color(0xFF444974);
  static Color clockOutline = Color(0xFFEAECFF);
  static Color secHandColor = Colors.orange[300];
  static Color minHandStatColor = Color(0xFF748EF6);
  static Color minHandEndColor = Color(0xFF77DDFF);
  static Color hourHandStatColor = Color(0xFFC279FB);
  static Color hourHandEndColor = Color(0xFFEA74AB);
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);


  static List<Color> rainbow = [Colors.yellow, Colors.lightBlue];
  static List<Color> atlas = [Color(0xFFFEAC5E), Color(0xFFC779D0),Color(0xFF4BC0C8)];
  static List<Color> sea = [Color(0xFF654ea3), Color(0xFFeaafc8)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];

}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [

    GradientColors(GradientColors.rainbow),
    GradientColors(GradientColors.atlas),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
