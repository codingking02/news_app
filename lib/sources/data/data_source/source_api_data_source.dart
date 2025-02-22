import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/sources/data/data_source/source_data_source.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';
import 'package:news_app/sources/data/model/source_response/source_response.dart';

class SourceApiDataSource extends SourceDataSource {
  @override
  Future<List<Source>> getSources(MyCategory category) async {
    Uri uri = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.sourceEndPotint,
      {
        'category': category.id.toLowerCase(),
        'apiKey': ApiConstants.apiKey,
      },
    );
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> responsebody = jsonDecode(response.body);
      SourceResponse sourceResponse = SourceResponse.fromJson(responsebody);
      if (sourceResponse.status == 'ok' || sourceResponse.sources != null) {
        return sourceResponse.sources ?? [];
      } else {
        throw Exception("Failed To Get Sources");
      }
    } else {
      throw Exception("Failed To Get Sources");
    }
  }
}
