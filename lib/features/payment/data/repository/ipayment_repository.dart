import 'package:ani4h_app/features/payment/data/dto/payment_request.dart';
import 'package:ani4h_app/features/payment/data/dto/payment_response.dart';

abstract interface class IPaymentRepository {
  Future<PaymentResponse> getPaymentUrl(PaymentRequest request);
}