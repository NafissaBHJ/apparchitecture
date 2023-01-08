import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key, required this.mobile, required this.web});

  final Widget mobile;
  final Widget web;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;
  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= 890;
  static bool isTab(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width <= 890;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth >= 650) {
        return web;
      } else {
        return mobile;
      }
    }));
  }
}
