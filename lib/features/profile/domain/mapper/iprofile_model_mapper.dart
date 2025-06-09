import 'package:ani4h_app/features/movie_detail/data/dto/episode_detail_response/episode_detail_response.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/episodes_response/episodes_response.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/episode_detail_model.dart';
import 'package:ani4h_app/features/profile/data/dto/profile_response.dart';
import 'package:ani4h_app/features/profile/domain/model/profile_model.dart';

abstract class IProfileModelMapper {
  ProfileModel mapToProfileModel(ProfileResponse response);
}