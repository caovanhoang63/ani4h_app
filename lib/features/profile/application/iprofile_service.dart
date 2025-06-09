import 'package:ani4h_app/features/profile/domain/model/profile_model.dart';
import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/profile/domain/model/profile_simple_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IProfileService {
  Future<Result<ProfileModel, Failure>> getProfile(String id);
  Future<Result<ProfileSimpleModel, Failure>> getUserIdByEmail(String email);
}