import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/settings/theme/apptheme.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {required this.currentIndex, required this.myCategory, super.key});
  final MyCategory myCategory;
  int currentIndex;
  bool get isEven => currentIndex % 2 == 0;
  bool get isBigger => currentIndex > 2;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/${myCategory.imageName}.png',
            height: 198.04.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 16,
            right: isEven
                ? isBigger
                    ? 180.w
                    : 16.w
                : isBigger
                    ? 16.w
                    : 180.w,
            child: Container(
              height: 54.h,
              width: 169.w,
              decoration: BoxDecoration(
                color: AppTheme.grey,
                borderRadius: BorderRadius.circular(84.r),
              ),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    'View All',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                  Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
