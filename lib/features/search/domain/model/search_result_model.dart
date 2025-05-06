import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_model.freezed.dart';
@freezed
sealed class SearchResultModel with _$SearchResultModel {
  const factory SearchResultModel({
    required List<FilmCardModel> data,
    required PagingSearch paging,
  }) = _SearchResultModel;
}

@freezed
sealed class FilmCardModel with _$FilmCardModel {
  const factory FilmCardModel({
    required String id,
    required String title,
    required String synopsis,
    required String imageUrl,
    required List<Genre> genres,
  }) = _FilmCardModel;
}