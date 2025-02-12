import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/news/data/model/news_response/news_response.dart';
import 'package:news_app/sources/data/model/source_response/source_response.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsApi {
  String basUrl = 'https://newsapi.org/';
  String sourceEndPotint = 'v2/top-headlines/sources';
  String topHeadlineEndPoint = 'v2/top-headlines';
  Future<SourceResponse> getCategorySources(MyCategory category) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          '$basUrl$sourceEndPotint?category=${category.id.toLowerCase()}&apiKey=8ddbc606264a430a95cec2df36bd87a3',
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responsebody = jsonDecode(response.body);
        return SourceResponse.fromJson(responsebody);
      } else {
        print(response.body);
        return SourceResponse();
      }
    } catch (error) {
      print(error.toString());
      return SourceResponse();
    }
  }

  Future<NewsResponse> getNewsFromSource(
    String sourceId,
    BuildContext context,
  ) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          'https://newsapi.org/v2/top-headlines?sources=$sourceId&apiKey=8ddbc606264a430a95cec2df36bd87a3',
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responsebody = jsonDecode(response.body);
        print(responsebody);
        Provider.of<NewsProvider>(context, listen: false).setResponse(
          NewsResponse.fromJson(responsebody),
        );
        return NewsResponse.fromJson(responsebody);
      } else {
        print(response.body);
        return NewsResponse();
      }
    } catch (error) {
      print(error.toString());
      return NewsResponse();
    }
  }
}
