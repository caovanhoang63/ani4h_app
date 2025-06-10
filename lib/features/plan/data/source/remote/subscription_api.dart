import 'package:ani4h_app/features/plan/data/dto/subscriptions_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/data/remote/endpoint.dart';
import '../../../../../core/data/remote/network_service.dart';

part 'subscription_api.g.dart';

final subscriptionApiProvider = Provider<SubscriptionApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return SubscriptionApi(dio);
});

@RestApi()
abstract class SubscriptionApi {
  factory SubscriptionApi(Dio dio) => _SubscriptionApi(dio);

  @GET("$userEndPoint/{id}/subscription")
  Future<SubscriptionsResponse> getUserSubscription(@Path("id") String id);


}