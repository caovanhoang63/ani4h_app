import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/profile/data/dto/profile_response.dart';
import 'package:ani4h_app/features/profile/data/dto/profile_simple_response.dart';
import 'package:ani4h_app/features/profile/data/repository/iprofile_repository.dart';
import 'package:ani4h_app/features/profile/data/source/remote/profile_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<IProfileRepository>((ref) {
  final profileApi = ref.watch(profileApiProvider);
  return ProfileRepository(profileApi);
});

final class ProfileRepository with DioExceptionMapper implements IProfileRepository {
  final ProfileApi _profileApi;

  ProfileRepository(this._profileApi);

  @override
  Future<ProfileResponse> getProfile(String id) async {
    try {
      final response = await _profileApi.getProfile(id);
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

  @override
  Future<ProfileSimpleResponse> getUserIdByEmail(String email) async {
    try {
      final response = await _profileApi.getUserIdByEmail(email);
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