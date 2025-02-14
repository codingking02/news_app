import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/provider/settings_provider.dart';
import 'package:news_app/settings/theme/apptheme.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {required this.currentIndex, required this.myCategory, super.key});
  final MyCategory myCategory;
  int currentIndex;
  bool get isEven => currentIndex % 2 == 0;
  bool get isBigger => currentIndex > 2;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: Stack(
        children: [
          Image.asset(
            isDark
                ? 'assets/images/${myCategory.imageName}_light.png'
                : 'assets/images/${myCategory.imageName}_dark.png',
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
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              height: 54.h,
              width: 169.w,
              decoration: BoxDecoration(
                color: AppTheme.grey,
                borderRadius: BorderRadius.circular(84.r),
              ),
              child: Row(
                textDirection: isEven
                    ? isBigger
                        ? TextDirection.rtl
                        : TextDirection.ltr
                    : isBigger
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                spacing: 0,
                children: [
                  Spacer(),
                  Text(
                    'View All',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 54.h,
                    width: 54.w,
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.black : AppTheme.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isEven
                          ? isBigger
                              ? Icons.arrow_back_ios_outlined
                              : Icons.arrow_forward_ios_outlined
                          : isBigger
                              ? Icons.arrow_forward_ios_outlined
                              : Icons.arrow_back_ios_outlined,
                      color: isDark ? AppTheme.white : AppTheme.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
