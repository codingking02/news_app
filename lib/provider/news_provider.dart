import 'package:flutter/material.dart';
import 'package:news_app/news/data/model/news_response/news_response.dart';

class NewsProvider with ChangeNotifier {
  NewsResponse newsResponse = NewsResponse();
  void setResponse(NewsResponse news) {
    newsResponse = news;
  }
}
