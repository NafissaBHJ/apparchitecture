import 'package:flutter/material.dart';

class HomeManager {
  final notifier =
      ValueNotifier<GlobalKey<ScaffoldState>>(GlobalKey<ScaffoldState>());
  final menuStateNotifier = ValueNotifier<bool>(false);

  void update() {
    print(notifier.value.currentState);
    notifier.value.currentState!.openDrawer();
  }

  void updateMenuState() {
    menuStateNotifier.value = !menuStateNotifier.value;
    menuStateNotifier.notifyListeners();
  }
}
