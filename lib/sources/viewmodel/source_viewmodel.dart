import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/sources/data/data_source/source_api_data_source.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';
import 'package:news_app/sources/data/model/source_response/source_response.dart';
import 'package:news_app/sources/repositories/sources_repository.dart';

class SourceViewmodel with ChangeNotifier {
  SourcesRepository sourcesRepository =
      SourcesRepository(SourceApiDataSource());

  List<Source> sources = [];
  bool isLoading = false;
  String? errorMessage;
  Future<void> getSources(MyCategory category) async {
    isLoading = true;
    try {
      sources = await sourcesRepository.getSources(category);
    } catch (error) {
      errorMessage = errorMessage.toString();
      throw errorMessage ?? '';
    }
    isLoading = false;
    notifyListeners();
  }
}
