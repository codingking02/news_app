import 'package:news_app/model/category.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';

abstract class SourceDataSource {
  Future<List<Source>> getSources(MyCategory category);
}
