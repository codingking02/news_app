import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/theme/apptheme.dart';
import 'package:news_app/view/home/home_screen.dart';

void main() {
  runApp(const News());
}

class News extends StatelessWidget {
  const News({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
