import 'package:get_it/get_it.dart';
import 'package:news_app/news/data/data_source/news_api_data_source.dart';
import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/sources/data/data_source/source_api_data_source.dart';
import 'package:news_app/sources/data/data_source/source_data_source.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<SourceDataSource>(
    () => SourceApiDataSource(),
  );
  getIt.registerLazySingleton<NewsDataSource>(
    () => NewsApiDataSource(),
  );
}
