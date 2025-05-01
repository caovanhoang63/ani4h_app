import 'package:ani4h_app/features/favorite/domain/model/favorite_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_state.freezed.dart';
@freezed
sealed class FavoriteState with _$FavoriteState {
  const factory FavoriteState({
    @Default([]) List<FavoriteModel> favorites,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _FavoriteState;
}
