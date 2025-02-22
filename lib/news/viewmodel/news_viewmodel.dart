import 'package:flutter/material.dart';
import 'package:news_app/news/data/data_source/news_api_data_source.dart';
import 'package:news_app/news/data/model/news_response/article.dart';
import 'package:news_app/news/data/model/news_response/news_response.dart';
import 'package:news_app/news/repositories/news_repository.dart';

class NewsViewmodel with ChangeNotifier {
  NewsRepository newsRepository = NewsRepository(NewsApiDataSource());
  List<Article> articles = [];
  List<Article> allArticles = [];
  bool isLoading = false;
  bool hasMoreData = true;
  int page = 1;
  int pageSize = 3;
  String? errorMessage;
  Future<void> getNews(
    String sourceId,
  ) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;
    try {
      List<Article> myArticles =
          await newsRepository.getNews(sourceId, page, pageSize);
      articles.addAll(myArticles);
      page++;
      if (pageSize > myArticles.length) {
        hasMoreData = false;
      }
    } catch (error) {
      errorMessage = error.toString();
      throw errorMessage ?? '';
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllNews(String sourceId) async {
    try {
      allArticles = await newsRepository.getAllNews(
        sourceId,
      );
    } catch (error) {
      errorMessage = error.toString();
      throw errorMessage ?? '';
    }
    notifyListeners();
  }

  void resetNews() {
    articles.clear();
    isLoading = false;
    page = 1;
    errorMessage = null;
    hasMoreData = true;
    notifyListeners();
  }
}
