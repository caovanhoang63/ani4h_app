import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'subscriptions_response.freezed.dart';
part 'subscriptions_response.g.dart';

@freezed
sealed class SubscriptionsResponse with _$SubscriptionsResponse {
  const factory SubscriptionsResponse({
    required List<Datum> data,
  }) = _SubscriptionsResponse;

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionsResponseFromJson(json);
}

@freezed
sealed class Datum with _$Datum {
  const factory Datum({
    required String id,
    required String name,
    required int price,
    required String? quality,
    required String? resolution,
    required int? maxSimultaneousStreams,
    required int? status,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}
