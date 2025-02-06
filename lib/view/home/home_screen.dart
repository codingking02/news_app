import 'package:flutter/material.dart';
import 'package:news_app/theme/apptheme.dart';
import 'package:news_app/view/categories/categories_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: CategoriesView(),
    );
  }
}
