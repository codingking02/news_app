import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/news/data/model/news_response/article.dart';
import 'package:news_app/news/data/model/news_response/news_response.dart';

class NewsApiDataSource extends NewsDataSource {
  @override
  Future<List<Article>> getNews(
    String sourceId,
    int page,
    int pageSize,
  ) async {
    Uri uri =
        Uri.https(ApiConstants.baseUrl, ApiConstants.topHeadlineEndPoint, {
      'sources': sourceId,
      'apiKey': ApiConstants.apiKey,
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    });
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> responsebody = jsonDecode(response.body);
      NewsResponse newsResponse = NewsResponse.fromJson(responsebody);
      if (newsResponse.status == 'ok' || newsResponse.articles != null) {
        return newsResponse.articles ?? [];
      } else {
        throw Exception("Failed To Get News");
      }
    } else {
      throw Exception("Failed To Get News");
    }
  }

  @override
  Future<List<Article>> getAllNews(
    String sourceId,
  ) async {
    Uri uri =
        Uri.https(ApiConstants.baseUrl, ApiConstants.topHeadlineEndPoint, {
      'sources': sourceId,
      'apiKey': ApiConstants.apiKey,
    });
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> responsebody = jsonDecode(response.body);

      NewsResponse newsResponse = NewsResponse.fromJson(responsebody);
      if (newsResponse.status == 'ok' || newsResponse.articles != null) {
        return newsResponse.articles ?? [];
      } else {
        throw Exception("Failed To Get News");
      }
    } else {
      throw Exception("Failed To Get News");
    }
  }
}
