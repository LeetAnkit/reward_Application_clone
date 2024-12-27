import 'dart:math';
import 'package:flutter/material.dart';

typedef CollapseWidgetBuilder = Widget Function(BuildContext context, double offset);

class SliverCollapseHeader extends SliverPersistentHeader {
  SliverCollapseHeader({
    required this.minHeight,   // added required keywords
    required this.maxHeight,
    required this.builder,
  }) : super(
    pinned: true,
    floating: true,
    delegate: SliverCollapseHeaderDelegate(
      minHeight: minHeight,
      maxHeight: maxHeight,
      builder: builder,
    ),
  );

  final double minHeight;
  final double maxHeight;
  final CollapseWidgetBuilder builder;
}

class SliverCollapseHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverCollapseHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
  });
  final double minHeight;
  final double maxHeight;
  final CollapseWidgetBuilder builder;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double offset = shrinkOffset / (maxExtent - minExtent);
    return builder(context, min(1, offset));
  }

  @override
  bool shouldRebuild(covariant SliverCollapseHeaderDelegate oldDelegate) {  // used whether rebuild is need or not
    return oldDelegate.minHeight != minHeight ||   // new height is different from older than it returns true, Means the rebuilt is necessary
        oldDelegate.maxHeight != maxHeight ||      // similary for the maxheight
        oldDelegate.builder != builder;            //   if it chnages it also return ture.
  }
}



