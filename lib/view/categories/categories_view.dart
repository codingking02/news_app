import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/widgets/category/category_item.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({required this.onCategorySelected, super.key});
  void Function(MyCategory) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Good Morning\nHere is Some News For You',
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.6),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 16.h),
              itemBuilder: (context, index) {
                return Padding(
                  padding: index == MyCategory.myCategories.length - 1
                      ? EdgeInsets.only(bottom: 16.h)
                      : EdgeInsets.zero,
                  child: InkWell(
                    onTap: () {
                      onCategorySelected(MyCategory.myCategories[index]);
                    },
                    child: CategoryItem(
                      myCategory: MyCategory.myCategories[index],
                      currentIndex: index,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16.h,
                );
              },
              itemCount: MyCategory.myCategories.length,
            ),
          ),
        ],
      ),
    );
  }
}
