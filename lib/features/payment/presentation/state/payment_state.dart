import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_state.freezed.dart';

@freezed
sealed class PaymentState with _$PaymentState {
  const factory PaymentState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(false) bool isSuccess,
    @Default('') String errorMessage,
    String? paymentCode,
  }) = _PaymentState;
} 