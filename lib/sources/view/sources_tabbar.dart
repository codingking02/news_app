import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/settings/theme/apptheme.dart';
import 'package:news_app/sources/widgets/tab_item.dart';

import '../data/model/source_response/source.dart';

class DefaultTabBar extends StatelessWidget {
  DefaultTabBar({
    required this.onTap,
    required this.currentIndex,
    required this.sources,
    super.key,
  });
  List<Source> sources;
  int currentIndex;
  void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: sources.length,
      child: TabBar(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
        ),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicatorColor: AppTheme.white,
        labelPadding: EdgeInsetsDirectional.only(end: 16.w),
        dividerColor: Colors.transparent,
        onTap: onTap,
        tabs: sources.map((source) {
          return TabItem(
            source: source,
            isSelected: currentIndex == sources.indexOf(source),
          );
        }).toList(),
      ),
    );
  }
}
