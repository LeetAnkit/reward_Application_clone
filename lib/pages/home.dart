import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dashboard_template/components/coordinator_layout.dart';
import 'package:dashboard_template/components/header.dart';
import 'package:dashboard_template/dummies/transaction.dart';
import 'package:dashboard_template/views/categories.dart';
import 'package:dashboard_template/views/items.dart';
import 'package:dashboard_template/views/summary_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Menu {
  final IconData icon;
  final String title;

  Menu(this.icon, this.title);
}

List<Menu> menus = [
  Menu(Icons.home, "Home"),
  Menu(Icons.multiline_chart, "Visualize"),
  Menu(Icons.card_giftcard, "Reward"),
  Menu(Icons.settings, "Settings"),
  Menu(Icons.phone, "Contact"),
];

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  double minHeight = 0;
  double maxHeight = 360;
  int maxValue = 1000;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    minHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            CoordinatorLayout(
              snap: true,
              scrollController: scrollController,
              header: buildCollapseHeader(context),
              body: buildMainContent(context),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).canvasColor,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Theme.of(context).disabledColor,
              selectedItemColor: Theme.of(context).colorScheme.secondary,
              elevation: 4,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: menus
                  .map((e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.title,
              ))
                  .toList(),
              onTap: (index) {
                if (index == 3) {
                  // Navigate to the Settings page on the "Settings" tab
                  Navigator.pushNamed(context, '/settings');
                } else if (index == 4) {
                  // Navigate to the Contact page on the "Contact" tab
                  Navigator.pushNamed(context, '/contact');
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchBox() {
    double height = 48;
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: height,
        padding: EdgeInsets.only(left: height / 2, right: height / 2 - 12),
        child: TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 16, bottom: 14),
            hintText: "What you wish for?",
            suffixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          CategoriesList(),
          buildSearchBox(),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Recommended for you",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ItemList(label: "New"),
          ItemList(label: "Hot"),
        ],
      ),
    );
  }

  final NumberFormat _numberFormat = NumberFormat("###,###,###");

  Card buildPointSummary({
    required String title,
    required double value,
    required Color color,
    required Widget icon,
    required double rate,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 120,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).hintColor),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: <Widget>[
                      Text(
                        _numberFormat.format(value),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        width: 1,
                        height: 12,
                        color: Theme.of(context).dividerColor,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            rate > 0
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: rate > 0
                                ? Colors.green.shade600
                                : Colors.red.shade600,
                            size: 24,
                          ),
                          SizedBox(width: 4),
                          Text(
                            _numberFormat.format(rate),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FloatingActionButton.extended(
              heroTag: "view-transaction",
              onPressed: () {
                Navigator.of(context).pushNamed("/transaction");
              },
              label: Text("View"),
            ),
          ],
        ),
      ),
    );
  }

  double offset = 0;

  SliverCollapseHeader buildCollapseHeader(BuildContext context) {
    return SliverCollapseHeader(
      minHeight: minHeight + 100,
      maxHeight: maxHeight,
      builder: (context, offset) {
        this.offset = offset;
        return Stack(
          children: <Widget>[
            Positioned.fill(
              bottom: 50,
              child: buildHeader(context, offset),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: buildPointSummary(
                        title: "Received",
                        value: 10000 + sum(totalReceived),
                        rate: totalReceived.last.y - totalRedeem.last.y,
                        color: Colors.green,
                        icon: Icon(Icons.arrow_upward),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildHeader(BuildContext context, double offset) {
    return IgnorePointer(
        ignoring: false,
        child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        Theme.of(context).primaryColor,
    Theme.of(context).primaryColorDark,
    ],
    ),
    borderRadius: BorderRadius.vertical(
    bottom: Radius.circular(16 * (1 - offset)),
    ),
    ),
    child: SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    child: Container(
    height: maxHeight - 50,
    child: Stack(
    children: <Widget>[
    Positioned(
    left: 0,
    right: 0,
    top: 24 * (1 - offset),
    child: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    title: Container(
    child: Text(
    offset == 1 ? "Home" : "Hi Michael,",
    style: TextStyle(fontSize: 18 + 16 * (1 - offset)),
    ),
    ),
    actions: <Widget>[
    IconButton(
    icon: Icon(Icons.notifications),
    onPressed: () {
    debugPrint("Notifications clicked");
    },
    ),
    ],
    ),
    ),
    Positioned(
    top: kToolbarHeight + 90,
    left: 0,
      right: 0,
      bottom: 0,
      child: Opacity(
        opacity: 1 - offset,
        child: SummaryChart(
          data1: totalReceived,
          data2: totalRedeem,
          maxValue: maxValue,
        ),
      ),
    ),
    ],
    ),
    ),
    ),
        ),
    );
  }

  double sum(List<FlSpot> data) {
    return data.fold(0, (previousValue, element) => previousValue + element.y);
  }
}


