import 'package:flutter/material.dart';

class Statistic {
  String? num;
  String? title;
  IconData? icon;
  String? subA, typeA;
  String? subB, typeB;
  String? subC, typeC;
  Statistic(
      {this.num,
      this.title,
      this.icon,
      this.subA,
      this.typeA,
      this.typeB,
      this.subB,
      this.subC,
      this.typeC});
}

List demoStatistic = [
  Statistic(
      num: "22",
      title: "Today's Patients",
      subA: "12",
      icon: Icons.people,
      typeA: "Women",
      typeB: "Men",
      subB: "10"),
  Statistic(
      num: "2",
      title: "Today's Children Patients",
      subA: "1",
      icon: Icons.child_care_rounded,
      typeA: "Girl",
      typeB: "Boy",
      subB: "1"),
  Statistic(
      num: "122",
      title: "This month's Patients",
      icon: Icons.calendar_month_rounded,
      subA: "60",
      typeA: "Women",
      typeB: "Men",
      subB: "32",
      subC: "30",
      typeC: "Children"),
  Statistic(
      num: "20600.00 DZA",
      title: "Receipt",
      icon: Icons.receipt_long,
      subA: "5000.00 DZA",
      typeA: "Remain")
];
