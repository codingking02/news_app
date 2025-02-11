import 'package:flutter/material.dart';
import 'package:news_app/model/mynews.dart';

class NewsProvider with ChangeNotifier {
  List<MyNews> mynews = [];
  void selectNews(List<MyNews> news) {
    mynews = news;
    notifyListeners();
  }
}
