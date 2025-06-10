import 'package:ani4h_app/features/payment/application/payment_service.dart';
import 'package:ani4h_app/features/payment/data/dto/payment_request.dart';
import 'package:ani4h_app/features/payment/data/dto/payment_response.dart';
import 'package:ani4h_app/features/payment/presentation/state/payment_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentControllerProvider =
    StateNotifierProvider<PaymentController, PaymentState>((ref) {
  return PaymentController(ref);
});

class PaymentController extends StateNotifier<PaymentState> {
  final Ref ref;

  PaymentController(this.ref) : super(const PaymentState());

  Future<PaymentResponse?> createPayment(PaymentRequest request) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: "");

      final result = await ref.read(paymentServiceProvider).getPaymentUrl(request);

      return result.when((response) {
          state = state.copyWith(
            isLoading: false,
            isSuccess: true,
          );
          return response;
        },
        (failure) {
          state = state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: "",
          );
          return null;
        },

      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      return null;
    }
  }

  /*Future<void> verifyPayment(Map<String, String> params) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: "");

      final result = await ref.read(paymentServiceProvider).verifyPayment(params);

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: failure.message,
          );
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            isSuccess: true,
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
  }*/
} 