import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/mynews.dart';
import 'package:news_app/view/news/news_view.dart';
import 'package:news_app/theme/apptheme.dart';
import 'package:news_app/view/categories/categories_view.dart';
import 'package:news_app/view/news/searchnews_view.dart';
import 'package:news_app/widgets/drawer/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyCategory? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shape: BeveledRectangleBorder(),
        width: 269.w,
        backgroundColor: AppTheme.black,
        child: HomeDrawer(
          onTap: resetSelectedCategory,
        ),
      ),
      appBar: AppBar(
        title: Text(
          selectedCategory == null ? 'Home' : selectedCategory?.name ?? 'Home',
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: 16.w,
            ),
            child: InkWell(
              onTap: () {
                if (selectedCategory == null) return;
                Navigator.pushNamed(context, SearchNews.routeName);
              },
              child: SvgPicture.asset(
                'assets/icons/search.svg',
              ),
            ),
          ),
        ],
      ),
      body: selectedCategory == null
          ? CategoriesView(onCategorySelected: onCategorySelected)
          : NewsView(
              category: selectedCategory!,
            ),
    );
  }

  void onCategorySelected(MyCategory category) {
    selectedCategory = category;
    setState(() {});
  }

  void resetSelectedCategory() {
    if (selectedCategory == null) return;
    selectedCategory = null;
    setState(() {});
  }
}
