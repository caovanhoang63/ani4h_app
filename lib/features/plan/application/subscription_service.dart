import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/plan/data/dto/subscriptions_response.dart';
import 'package:ani4h_app/features/plan/domain/model/subscription_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/src/result.dart';
import '../data/repository/isubscription_repository.dart';
import '../data/repository/subscription_repository.dart';
import '../domain/mapper/isubscription_model_mapper.dart';
import 'isubscription_service.dart';

final subscriptionServiceProvider = Provider<ISubscriptionService>((ref) {
  final subscriptionRepository = ref.watch(subscriptionRepositoryProvider);
  return SubscriptionService(subscriptionRepository);
});


class SubscriptionService implements ISubscriptionService {
  final ISubscriptionRepository _repository;

  SubscriptionService(this._repository);

  @override
  Future<Result<bool,Failure>> hasActiveSubscription(String userId) async {
    try {
      final response = await _repository.getUserSubscription(userId);
      if (response.data.isEmpty) {
        return Result.success(false);
      }
      return Result.success(true);
    } catch (e, s) {
      print("Error checking active subscription: $e");
      throw Exception("Failed to check active subscription: $e");
    }
  }


}