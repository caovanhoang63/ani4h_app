import 'package:ani4h_app/features/plan/application/subscription_service.dart';
import 'package:ani4h_app/features/plan/presentation/state/subscription_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscriptionControllerProvider = NotifierProvider<SubscriptionController, SubscriptionState>(SubscriptionController.new);


class SubscriptionController extends Notifier<SubscriptionState> {

  @override
  SubscriptionState build() {
    return SubscriptionState();
  }

  Future<void> getUserSubscription(String id) async {
    try {
      state = state.copyWith(isLoading: true, hasError: false, errorMessage: '');

      final result = await ref.read(subscriptionServiceProvider).hasActiveSubscription(id);
      result.when(
            (subscription) {
          state = state.copyWith(
            hasSubscription: subscription,
            isLoading: false,
          );
        },
            (failure) {
          state = state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: failure.message,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

}