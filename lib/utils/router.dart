import 'package:dashboard/screens/home/home_screen.dart';
import 'package:dashboard/screens/home/home_screen_manager.dart';
import 'package:dashboard/screens/home/test_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';


class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case pageRoute:
        return MaterialPageRoute(builder: (_) => TestScreen());

      default:
        return MaterialPageRoute(builder: (_) => MyHomePage());
    }
  }
}
