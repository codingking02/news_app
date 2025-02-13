import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/sources/data/data_source/source_data_source.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';
import 'package:news_app/sources/data/model/source_response/source_response.dart';

class SourceViewmodel with ChangeNotifier {
  SourceDataSource sourceDataSource = SourceDataSource();
  List<Source> sources = [];
  bool isLoading = false;
  String? errorMessage;
  Future<void> getSources(MyCategory category) async {
    isLoading = true;
    try {
      SourceResponse response =
          await sourceDataSource.getCategorySources(category);
      if (response.sources != null || response.status == 'ok') {
        sources = response.sources ?? [];
      } else {
        throw 'Failed To Get Sources';
      }
    } catch (error) {
      errorMessage = errorMessage.toString();
      throw errorMessage ?? '';
    }
    isLoading = false;
    notifyListeners();
  }
}
