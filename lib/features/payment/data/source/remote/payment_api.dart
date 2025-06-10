import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/home/data/dto/movies_response/movies_response.dart';
import 'package:ani4h_app/features/payment/data/dto/payment_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../dto/payment_request.dart';

part 'payment_api.g.dart';

final paymentApiProvider = Provider<PaymentApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return PaymentApi(dio);
});

@RestApi()
abstract class PaymentApi {
  factory PaymentApi(Dio dio) => _PaymentApi(dio);

  @POST("$paymentEndPoint/create")
  Future<PaymentResponse> getPaymentUrl(@Body() PaymentRequest request);
}