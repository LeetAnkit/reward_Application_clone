import 'package:dashboard_template/components/header.dart';
import 'package:flutter/material.dart';

class CoordinatorLayout extends StatefulWidget {
  CoordinatorLayout({
    Key? key,     // here can be nullable
    required this.header,
    required this.body,
    this.scrollController,
    this.snap = true,
    this.overlap = false,
  }) : super(key: key);
  final SliverCollapseHeader header;
  final Widget body;
  final ScrollController? scrollController;
  final bool snap;
  final bool overlap;

  @override
  _CoordinatorLayoutState createState() => _CoordinatorLayoutState();
}

class _CoordinatorLayoutState extends State<CoordinatorLayout> {
  late ScrollController scrollController;
  //this will prevnt potential null reference errors
  //it will be initialized in the initState method before any UI code attempts to access it
  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController ?? ScrollController();  // nullable in newer versions
  }

  @override
  Widget build(BuildContext context) {
    return buildNestedScrollView();
  }

  Widget buildNestedScrollView() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          double range = widget.header.maxHeight - widget.header.minHeight;
          if (scrollController.offset > 0 && scrollController.offset < range) {
            if (scrollController.offset < range / 2) {
              scrollController.animateTo(
                0,
                duration: Duration(milliseconds: 100),
                curve: Curves.ease,
              ).then((value) => scrollController.jumpTo(0));
            } else {
              scrollController.animateTo(
                range,
                duration: Duration(milliseconds: 100),
                curve: Curves.ease,
              ).then((value) => scrollController.jumpTo(range));
            }
          }
        }
        return false;
      },
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            widget.header,
          ];
        },
        body: SingleChildScrollView(
          child: widget.body,
        ),
      ),
    );
  }
}
//
// Changed Key key to Key? key to handle null safety.
//
// Made header and body required parameters.
//
// Made scrollController nullable (ScrollController?).
//
// Used late for the scrollController to ensure it’s properly initialized.
