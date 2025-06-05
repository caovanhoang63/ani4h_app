import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/features/favorite/domain/model/favorite_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_state.freezed.dart';
@freezed
sealed class FavoriteState with _$FavoriteState {
  const factory FavoriteState({
    @Default([]) List<FavoriteModel> favorites,
    @Default(Paging(pageSize: 10, page: 1))Paging paging,
    @Default("3w5rMJ7r2JjRwM") String userId,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(true) bool hasMore,
    @Default('') String errorMessage,
  }) = _FavoriteState;
}
