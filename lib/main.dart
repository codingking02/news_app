import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/provider/settings_provider.dart';
import 'package:news_app/theme/apptheme.dart';
import 'package:news_app/view/home/home_screen.dart';
import 'package:news_app/view/news/searchnews_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: News(),
    ),
  );
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
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        //locale: Locale(Provider.of<SettingsProvider>(context).languageCode),
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
          SearchNews.routeName: (_) => SearchNews(),
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
