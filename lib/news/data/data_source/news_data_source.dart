import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/news/data/model/news_response/news_response.dart';

class NewsDataSource {
  Future<NewsResponse> getNewsFromSource(
    String sourceId,
    int page,
    int pageSize,
  ) async {
    try {
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

        return NewsResponse.fromJson(responsebody);
      } else {
        return NewsResponse();
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
