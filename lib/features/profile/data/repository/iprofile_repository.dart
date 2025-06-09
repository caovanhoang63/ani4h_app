import 'package:ani4h_app/features/profile/data/dto/profile_response.dart';

import '../dto/profile_simple_response.dart';

abstract interface class IProfileRepository {
  Future<ProfileResponse> getProfile(String id);
  Future<ProfileSimpleResponse> getUserIdByEmail(String email);
}