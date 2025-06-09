

import '../../data/dto/profile_simple_response.dart';
import '../model/profile_simple_model.dart';

abstract class IProfileSimpleModelMapper {
  ProfileSimpleModel mapToProfileSimpleModel(ProfileSimpleResponse response);

}