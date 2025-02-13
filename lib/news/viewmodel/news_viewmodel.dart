import 'package:flutter/material.dart';
import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/news/data/model/news_response/article.dart';
import 'package:news_app/news/data/model/news_response/news_response.dart';

class NewsViewmodel with ChangeNotifier {
  NewsDataSource newsDataSource = NewsDataSource();
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
      NewsResponse newsResponse =
          await newsDataSource.getNewsFromSource(sourceId, page, pageSize);
      if (newsResponse.articles != null || newsResponse.status == 'ok') {
        articles.addAll(newsResponse.articles ?? []);
        page++;
        if (pageSize > newsResponse.articles!.length) {
          hasMoreData = false;
        }
      } else {
        throw 'Failed To Get Articles';
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
      NewsResponse newsResponse = await newsDataSource.getAllNews(sourceId);
      if (newsResponse.articles != null || newsResponse.status == 'ok') {
        allArticles = newsResponse.articles ?? [];
      } else {
        throw 'Failed To Get Articles';
      }
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
