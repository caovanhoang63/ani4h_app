import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'payment_request.freezed.dart';
part 'payment_request.g.dart';

@freezed
sealed class PaymentRequest with _$PaymentRequest {
  const factory PaymentRequest({
    required String userId,
    required int price,
  }) = _PaymentRequest;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => _$PaymentRequestFromJson(json);
}
