import 'package:ani4h_app/core/data/local/secure_storage/secure_storage.dart';
import 'package:ani4h_app/features/plan/application/subscription_service.dart';
import 'package:ani4h_app/features/profile/application/profile_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const hasSubscriptionState = "hasSubscriptionState";
final hasSubscriptionStateProvider = NotifierProvider<HasSubscriptionState, bool>(HasSubscriptionState.new);

class HasSubscriptionState extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  Future<void> hasSubscription(String userId) async {
    try {
      final subscription = await ref.read(subscriptionServiceProvider).hasActiveSubscription(userId);
      subscription.when(
            (data) async {
          final secureStorage = ref.read(secureStorageProvider);
          await secureStorage.write(hasSubscriptionState, data as String);
        },
            (failure) {
          print("Error fetching user ID: ${failure.message}");
        },
      );
    } catch (e) {
      print("Error loading auth state: $e");
    }
  }

}
