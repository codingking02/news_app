import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/mynews.dart';
import 'package:news_app/model/source.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsApi {
  String basUrl = 'https://newsapi.org/';
  String sourceEndPotint = 'v2/top-headlines/sources';
  String topHeadlineEndPoint = 'v2/top-headlines';
  Future<List<Source>> getCategorySources(MyCategory category) async {
    http.Response response = await http.get(
      Uri.parse(
        '$basUrl$sourceEndPotint?category=${category.id.toLowerCase()}&apiKey=8ddbc606264a430a95cec2df36bd87a3',
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responsebody = jsonDecode(response.body);
      return (responsebody['sources'] as List)
          .cast<Map<String, dynamic>>()
          .map(
            (source) => Source.fromJson(source),
          )
          .toList();
    } else {
      print(response.body);
      return [];
    }
  }

  Future<List<MyNews>> getNewsFromSource(
    String sourceId,
    BuildContext context,
  ) async {
    http.Response response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=$sourceId&apiKey=8ddbc606264a430a95cec2df36bd87a3',
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responsebody = jsonDecode(response.body);
      print(responsebody);
      List<MyNews> thenews = (responsebody['articles'] as List)
          .cast<Map<String, dynamic>>()
          .map(
            (mynews) => MyNews.fromJson(mynews),
          )
          .toList();
      if (thenews.isNotEmpty || thenews != null) {
        Provider.of<NewsProvider>(context, listen: false).selectNews(thenews);
      }

      return thenews;
    } else {
      print(response.body);
      return [];
    }
  }
}
