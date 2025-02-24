import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/service/service_locator.dart';
import 'package:news_app/service_loactor.dart';
import 'package:news_app/sources/data/data_source/source_data_source.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';
import 'package:news_app/sources/repositories/sources_repository.dart';

class SourceViewmodel with ChangeNotifier {
  SourcesRepository sourcesRepository =
      SourcesRepository(getIt<SourceDataSource>());

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
