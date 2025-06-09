import 'package:ani4h_app/features/plan/data/dto/subscriptions_response.dart';

abstract interface class ISubscriptionRepository {
  Future<SubscriptionsResponse> getUserSubscription(String id);
}