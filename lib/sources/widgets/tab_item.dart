import 'package:flutter/material.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';

class TabItem extends StatelessWidget {
  TabItem({required this.source, required this.isSelected, super.key});
  Source source;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      source.name ?? '',
      style: isSelected ? textTheme.titleMedium : textTheme.titleSmall,
    );
  }
}
