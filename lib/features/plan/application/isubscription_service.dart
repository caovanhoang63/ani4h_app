

import 'package:multiple_result/multiple_result.dart';

import '../../../common/exception/failure.dart';

abstract interface class ISubscriptionService {
  Future<Result<bool, Failure>> hasActiveSubscription(String id);
}