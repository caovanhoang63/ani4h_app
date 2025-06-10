import 'package:ani4h_app/features/plan/data/source/remote/subscription_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/exception/failure.dart';
import '../../../../common/mixin/dio_exception_mapper.dart';
import '../../application/isubscription_service.dart';
import '../dto/subscriptions_response.dart';
import 'isubscription_repository.dart';

final subscriptionRepositoryProvider = Provider<ISubscriptionRepository>((ref) {
  final subscriptionApi = ref.watch(subscriptionApiProvider);
  return SubscriptionRepository(subscriptionApi);
});


final class SubscriptionRepository with DioExceptionMapper implements ISubscriptionRepository {
  final SubscriptionApi _subscriptionApi;

  SubscriptionRepository(this._subscriptionApi);

  @override
  Future<SubscriptionsResponse> getUserSubscription(String userId) async {
    try {
      final response = await _subscriptionApi.getUserSubscription(userId);
      print("Subscription fetched successfully for user ádasdsad $userId: ${response.data}");
      return response;
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message: "An unexpected error occurred",
        exception: toException(e),
        stackTrace: s,
      );
    }
  }
}