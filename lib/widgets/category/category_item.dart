import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/model/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({required this.myCategory, super.key});
  final MyCategory myCategory;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: Image.asset(
        'assets/images/${myCategory.imageName}.png',
        height: 198.04.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
