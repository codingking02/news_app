import 'package:news_app/news/data/data_source/news_api_data_source.dart';
import 'package:news_app/news/data/data_source/news_data_source.dart';
import 'package:news_app/sources/data/data_source/source_api_data_source.dart';
import 'package:news_app/sources/data/data_source/source_data_source.dart';

class ServiceLocator {
  static SourceDataSource sourceDataSource = SourceApiDataSource();
  static NewsDataSource newsDataSource = NewsApiDataSource();
}
