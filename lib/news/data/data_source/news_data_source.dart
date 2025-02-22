import 'package:news_app/news/data/model/news_response/article.dart';

abstract class NewsDataSource {
  Future<List<Article>> getNews(String sourceId, int page, int pageSize);
  Future<List<Article>> getAllNews(String sourceId);
}
