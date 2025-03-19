import 'package:ani4h_app/features/movie_detail/domain/model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail_state.freezed.dart';

@freezed
sealed class MovieDetailState with _$MovieDetailState {
  const factory MovieDetailState({
    @Default([]) List<UserModel> users,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
    @Default(false) bool isLoginSuccess,
  }) = _MovieDetailState;
}