import 'package:news_app/model/category.dart';
import 'package:news_app/sources/data/data_source/source_data_source.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';

class SourcesRepository {
  SourceDataSource sourceDataSource;
  SourcesRepository(this.sourceDataSource);
  Future<List<Source>> getSources(MyCategory myCategory) async {
    return sourceDataSource.getSources(myCategory);
  }
}
