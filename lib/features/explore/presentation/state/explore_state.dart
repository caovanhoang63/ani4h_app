import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/domain/model/explore_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_state.freezed.dart';

@freezed
sealed class ExploreState with _$ExploreState {
  const factory ExploreState({
    @Default([]) List<ExploreModel> explores,
    @Default(ExploreParams(genreId: "iUwqRePSWQq3", year: 2025, season: "")) ExploreParams filter,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(true) bool hasMore,
    @Default('') String errorMessage,
  }) = _ExploreState;
}