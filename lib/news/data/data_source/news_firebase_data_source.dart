import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/news/data/model/news_response/article.dart';

class NewsFirebaseDataSource extends NewsDataSource {
  @override
  Future<List<Article>> getAllNews(String sourceId) async {
    return [];
  }

  @override
  Future<List<Article>> getNews(String sourceId, int page, int pageSize) async {
    return [];
  }
}
