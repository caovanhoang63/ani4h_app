import 'package:ani4h_app/features/profile/data/dto/profile_response.dart';
import 'package:ani4h_app/features/profile/domain/model/profile_model.dart';

abstract class IProfileModelMapper {
  ProfileModel mapToProfileModel(ProfileResponse response);
}