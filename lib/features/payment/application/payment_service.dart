import 'package:ani4h_app/features/payment/data/dto/payment_request.dart';
import 'package:ani4h_app/features/payment/data/dto/payment_response.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../common/exception/failure.dart';
import '../data/repository/payment_repository.dart';
import 'ipayment_service.dart';


final paymentServiceProvider = Provider<IPaymentService>((ref) {
  final repository = ref.watch(paymentRepositoryProvider) as PaymentRepository;
  return PaymentService(repository);
});

class PaymentService implements IPaymentService {
  final PaymentRepository _repository;

  PaymentService(this._repository);


  @override
  Future<Result<PaymentResponse, Failure>> getPaymentUrl(PaymentRequest request) async {
  try {
      final response = await _repository.getPaymentUrl(request);
      return Future.value(Success(response));
    } catch (e, s) {
      print("Error checking active subscription: $e");
  }
    throw UnimplementedError();
  }
} 