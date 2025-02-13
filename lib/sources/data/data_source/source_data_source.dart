import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constants.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/sources/data/model/source_response/source_response.dart';

class SourceDataSource {
  Future<SourceResponse> getCategorySources(MyCategory category) async {
    try {
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
        return SourceResponse.fromJson(responsebody);
      } else {
        print(response.body);
        return SourceResponse();
      }
    } catch (error) {
      print(error.toString());
      return SourceResponse();
    }
  }
}
