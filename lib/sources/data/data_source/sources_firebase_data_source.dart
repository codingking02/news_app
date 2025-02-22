import 'package:news_app/model/category.dart';
import 'package:news_app/sources/data/data_source/source_data_source.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';

class SourcesFirebaseDataSource extends SourceDataSource {
  @override
  Future<List<Source>> getSources(MyCategory category) async {
    return [];
  }
}
