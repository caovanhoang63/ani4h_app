


import 'package:ani4h_app/features/payment/data/dto/payment_request.dart';
import 'package:ani4h_app/features/payment/data/dto/payment_response.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../common/exception/failure.dart';

abstract interface class IPaymentService {
  Future<Result<PaymentResponse, Failure>> getPaymentUrl(PaymentRequest request);
}