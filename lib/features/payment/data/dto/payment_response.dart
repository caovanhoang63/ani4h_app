import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'payment_response.freezed.dart';
part 'payment_response.g.dart';

@freezed
sealed class PaymentResponse with _$PaymentResponse {
  const factory PaymentResponse({
    required Data data,
  }) = _PaymentResponse;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => _$PaymentResponseFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
    required String urlPayment,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
