import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/service_loactor.dart';
import 'package:news_app/sources/data/data_source/source_data_source.dart';
import 'package:news_app/sources/repositories/sources_repository.dart';
import 'package:news_app/sources/viewmodel/sources_states.dart';

class SourceViewmodel extends Cubit<SourcesStates> {
  SourcesRepository sourcesRepository =
      SourcesRepository(getIt<SourceDataSource>());
  SourceViewmodel() : super(SourcesInitial());

  Future<void> getSources(MyCategory category) async {
    emit(GetSourcesLoading());
    try {
      final sources = await sourcesRepository.getSources(category);
      emit(GetSourcesSuccess(sources: sources));
    } catch (error) {
      emit(GetSourcesError(errorMessage: error.toString()));
    }
  }
}
