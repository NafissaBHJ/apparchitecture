import 'package:dashboard/screens/home/test_screen.dart';
import 'package:dashboard/utils/constants.dart';
import 'package:dashboard/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'screens/home/home_screen.dart';
import 'services/service_locator.dart';
import 'utils/responsive.dart';
import 'utils/router.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      shimmerGradient: LinearGradient(
        colors: [
          Color(0xFFFFFFFF),
          Color(0xffcaf0f8),
          Color(0xFFDAF1F6),
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      child: MaterialApp(
        theme: lightTheme(context),
        onGenerateRoute: MyRouter.generateRoute,
        routes: {
          homeRoute: (context) => MyHomePage(),
          pageRoute: ((context) => TestScreen()),
        },
        home: const MyHomePage(),
      ),
    );
  }
}
