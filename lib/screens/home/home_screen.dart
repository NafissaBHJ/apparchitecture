import 'dart:async';
import 'dart:js_util';

import 'package:dashboard/models/consultations.dart';
import 'package:dashboard/models/rendezvous.dart';
import 'package:dashboard/screens/home/home_screen_manager.dart';
import 'package:dashboard/screens/home/test_screen.dart';
import 'package:dashboard/utils/constants.dart';
import 'package:dashboard/utils/responsive.dart';
import 'package:dashboard/utils/router.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../models/statistic.dart';
import '../../services/service_locator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool web = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDrawerBeingShown = false;
  @override
  void initState() {
    super.initState();
    isDrawerBeingShown = false;

    WidgetsBinding.instance.addPostFrameCallback(_showDrawer);
  }

  void _showDrawer(_) async {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      web: Scaffold(
        key: _scaffoldKey,
        appBar: Responsive.isMobile(context) ? AppBar() : null,
        body: SafeArea(
            child: Row(
          children: [
            Menu(web: web),
            Expanded(
                flex: 5,
                child: Dashboard(
                  web: web,
                )),
          ],
        )),
      ),
      mobile: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: SizedBox.shrink()),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DrawerTile(
                    title: "Home",
                    icon: Icons.home_outlined,
                  ),
                  DrawerTile(
                    title: "Appointements",
                    icon: Icons.list_alt_outlined,
                  ),
                  DrawerTile(
                    title: "Patients",
                    icon: Icons.group_rounded,
                  ),
                  DrawerTile(
                    title: "Upcoming",
                    icon: Icons.calendar_month_rounded,
                  ),
                  DrawerTile(
                    title: "Receipts",
                    icon: Icons.receipt,
                  ),
                  DrawerTile(
                    title: "settings",
                    icon: Icons.settings_rounded,
                  )
                ],
              )
            ],
          ),
        ),
        body: Dashboard(web: web),
      ),
    );
  }
}

class Menu extends StatefulWidget {
  Menu({
    Key? key,
    required this.web,
  }) : super(key: key);

  bool web;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final state = getit<HomeManager>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: state.menuStateNotifier,
        builder: (context, value, child) {
          return Container(
            color: Colors.transparent,
            child: AnimatedContainer(
                width: value == false || Responsive.isTab(context) ? 50 : 200,
                duration: const Duration(milliseconds: 100),
                child: Drawer(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            padding: EdgeInsets.only(bottom: 15),
                            icon: value == false
                                ? const Icon(Icons.arrow_forward)
                                : const Icon(Icons.arrow_back),
                            onPressed: () {
                              state.updateMenuState();
                            },
                          ),
                        ),
                      ),
                      value == false
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DrawerIcons(icon: Icons.home_rounded),
                                DrawerIcons(
                                  icon: Icons.fact_check_rounded,
                                ),
                                DrawerIcons(
                                  icon: Icons.group_rounded,
                                ),
                                DrawerIcons(
                                  icon: Icons.calendar_month_rounded,
                                ),
                                DrawerIcons(
                                  icon: Icons.receipt,
                                ),
                                DrawerIcons(
                                  icon: Icons.settings_rounded,
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                DrawerTile(
                                  title: "Dashboard",
                                  icon: Icons.home_rounded,
                                ),
                                DrawerTile(
                                  title: "Appointements",
                                  icon: Icons.fact_check_rounded,
                                ),
                                DrawerTile(
                                  title: "Patients",
                                  icon: Icons.group_rounded,
                                ),
                                DrawerTile(
                                  title: "Upcoming",
                                  icon: Icons.calendar_month_rounded,
                                ),
                                DrawerTile(
                                  title: "Receipts",
                                  icon: Icons.receipt,
                                ),
                                DrawerTile(
                                  title: "settings",
                                  icon: Icons.settings_rounded,
                                )
                              ],
                            )
                    ],
                  ),
                )),
          );
        });
  }
}

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, required this.web}) : super(key: key);
  bool web;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    print(widget.web);
    final Size _size = MediaQuery.of(context).size;
    return SafeArea(
        child: SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "Dashboard",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    ContainersT1Gridview(
                        childAspectRatio: Responsive.isWeb(context)
                            ? widget.web == false
                                ? 1.1
                                : 1.5
                            : 1,
                        crossAxisCount: Responsive.isWeb(context) ? 4 : 2),
                    const SizedBox(
                      height: 16,
                    ),
                    Consultations(
                      consult: demoConst,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (Responsive.isMobile(context))
                      Upcoming(
                        rendezv: demoList,
                      )
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              if (Responsive.isWeb(context))
                Expanded(
                    flex: 1,
                    child: Upcoming(
                      rendezv: demoList,
                    ))
            ],
          ),
        ],
      ),
    ));
  }
}

class Upcoming extends StatelessWidget {
  Upcoming({super.key, required this.rendezv});
  List<RendezVous> rendezv;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Upcoming",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  demoList.length,
                  (index) => ContainerData(
                        rv: demoList[index],
                      )),
            ),
          ],
        ));
  }
}

class ContainerData extends StatelessWidget {
  ContainerData({super.key, required this.rv});
  RendezVous rv;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      height: 110,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 36,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Container(
                  child: Text(
                    rv.time,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text(
                    rv.date,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text(
                  rv.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DrawerIcons extends StatelessWidget {
  DrawerIcons({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({Key? key, required this.title, required this.icon})
      : super(key: key);
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (() {
        // Navigator.of(context).pushNamed(pageRoute);
      }),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      leading: DrawerIcons(
        icon: icon,
      ),
    );
  }
}

class StatistiContainer extends StatelessWidget {
  const StatistiContainer({super.key, this.info});
  final Statistic? info;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Container(
      decoration: BoxDecoration(
        color: info == null
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary, width: 3),
      ),
      child: info == null
          ? SkeletonItem(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        height: 50, width: 50, shape: BoxShape.circle),
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 10,
                        width: 90,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 5,
                        padding: EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 5,
                        padding: EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment:
                    Responsive.isMobile(context) || Responsive.isTab(context)
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              info!.icon!,
                              size: Responsive.isMobile(context) ||
                                      Responsive.isTab(context)
                                  ? 64
                                  : 28,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              info!.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ],
                      )),
                  Text(
                    info!.num!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  MediaQuery.of(context).size.width > 900
                      ? SizedBox(
                          height: 32 * 0.75,
                        )
                      : SizedBox.shrink(),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          info!.typeA!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          info!.subA!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class Consultations extends StatelessWidget {
  const Consultations({super.key, required this.consult});
  final List<Consultation> consult;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Appointements",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
          Divider(),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: DataTable2(
                minWidth: 400,
                dataRowHeight: 60,
                columnSpacing: 12,
                columns: [
                  DataColumn(
                      label: Center(
                    child: Text(
                      "#",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    "Patient name",
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                  DataColumn(
                      label: Text(
                    "Date",
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                  DataColumn(
                      label: Text(
                    "Status",
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                  DataColumn(
                      label: Text(
                    "Notice",
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                  DataColumn(
                      label: Text(
                    "Upcoming",
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                ],
                rows: List.generate(consult.length,
                    (index) => DataRows(consult[index], context))),
          )
        ],
      ),
    );
  }
}

DataRow DataRows(Consultation data, BuildContext context) {
  return DataRow(cells: [
    DataCell(Center(
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, shape: BoxShape.circle),
        child: Text(
          data.name[0],
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    )),
    DataCell(Text(
      data.name,
      style: Theme.of(context).textTheme.bodyText1,
    )),
    DataCell(Text(
      data.date,
      style: Theme.of(context).textTheme.bodyText1,
    )),
    DataCell(Text(
      data.status,
      style: Theme.of(context).textTheme.bodyText1,
    )),
    DataCell(Text(
      data.notice,
      maxLines: 1,
      style: Theme.of(context).textTheme.bodyText1,
    )),
    DataCell(Text(
      data.upcoming,
      style: Theme.of(context).textTheme.bodyText1,
    ))
  ]);
}

class ContainersT1Gridview extends StatelessWidget {
  const ContainersT1Gridview(
      {super.key, this.childAspectRatio = 1, this.crossAxisCount = 4});
  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: demoStatistic.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: ((context, index) {
          return StatistiContainer(
            info: demoStatistic[index],
          );
        }));
  }
}
