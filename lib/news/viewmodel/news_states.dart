import 'package:news_app/news/data/model/news_response/article.dart';

abstract class NewsStates {}

class NewsInitial extends NewsStates {}

class GetNewsLoading extends NewsStates {
  final List<Article> articles;

  GetNewsLoading({required this.articles});
}

class GetNewsSuccess extends NewsStates {
  final List<Article> articles;
  final bool hasMoreData;

  GetNewsSuccess({required this.articles, required this.hasMoreData});
}

class GetNewsError extends NewsStates {
  final String errorMessage;

  GetNewsError({required this.errorMessage});
}
