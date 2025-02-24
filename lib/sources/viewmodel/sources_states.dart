import 'package:news_app/sources/data/model/source_response/source.dart';

abstract class SourcesStates {}

class SourcesInitial extends SourcesStates {}

class GetSourcesLoading extends SourcesStates {}

class GetSourcesSuccess extends SourcesStates {
  final List<Source> sources;
  GetSourcesSuccess({required this.sources});
}

class GetSourcesError extends SourcesStates {
  final String errorMessage;
  GetSourcesError({required this.errorMessage});
}
