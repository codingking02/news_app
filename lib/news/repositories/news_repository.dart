import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/news/data/model/news_response/article.dart';

class NewsRepository {
  NewsDataSource newsDataSource;
  NewsRepository(this.newsDataSource);
  Future<List<Article>> getNews(String sourceId, int page, int pageSize) async {
    return newsDataSource.getNews(sourceId, page, pageSize);
  }

  Future<List<Article>> getAllNews(
    String sourceId,
  ) async {
    return newsDataSource.getAllNews(sourceId);
  }
}
