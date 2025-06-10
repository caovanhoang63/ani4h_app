
import 'package:ani4h_app/features/signup/data/dto/sign_up_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_up_state.freezed.dart';
@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
    @Default(null) SignUpRequest? signUpRequest,
  }) = _SignUpState;
}