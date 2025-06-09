import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_model.freezed.dart';

@freezed
sealed class SubscriptionModel with _$SubscriptionModel {
  const factory SubscriptionModel({
    required String id,
    required String name,
    required int price,
    required String? quality,
    required String? resolution,
    required int? maxSimultaneousStreams,
    required int? status,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _SubscriptionModel;
}


