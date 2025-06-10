import 'package:ani4h_app/features/home/data/repository/ihome_repository.dart';
import 'package:ani4h_app/features/payment/data/dto/payment_request.dart';
import 'package:ani4h_app/features/payment/data/dto/payment_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';

import '../source/remote/payment_api.dart';
import 'ipayment_repository.dart';

final paymentRepositoryProvider = Provider<IPaymentRepository>((ref) {
  final paymentApi = ref.watch(paymentApiProvider);
  return PaymentRepository(paymentApi);
});

final class PaymentRepository with DioExceptionMapper implements IPaymentRepository {
  final PaymentApi _paymentApi;

  PaymentRepository(this._paymentApi);

  @override
  Future<PaymentResponse> getPaymentUrl(PaymentRequest request) async {
    try {
      final response = await _paymentApi.getPaymentUrl(request);
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