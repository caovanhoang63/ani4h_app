import 'package:ani4h_app/features/profile/data/dto/profile_response.dart';
import 'package:ani4h_app/features/profile/data/dto/profile_simple_response.dart';
import 'package:ani4h_app/features/profile/data/repository/iprofile_repository.dart';
import 'package:ani4h_app/features/profile/data/repository/profile_repository.dart';
import 'package:ani4h_app/features/profile/domain/mapper/iprofile_model_mapper.dart';
import 'package:ani4h_app/features/profile/domain/mapper/iprofile_simple_model_mapper.dart';
import 'package:ani4h_app/features/profile/domain/model/profile_model.dart';
import 'package:ani4h_app/features/profile/domain/model/profile_simple_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../common/exception/failure.dart';
import 'iprofile_service.dart';

final profileServiceProvider = Provider<IProfileService>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return ProfileService(profileRepository);
});

class ProfileService implements IProfileService, IProfileModelMapper, IProfileSimpleModelMapper {
  final IProfileRepository _repository;

  ProfileService(this._repository);

  @override
  Future<Result<ProfileModel, Failure>> getProfile(String id) async {
    try{
      final response = await _repository.getProfile(id);
      print("profilerepo: getProfile response: $response");
      final model = mapToProfileModel(response);
      return Result.success(model);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: toException(e),
          stackTrace: s,
        ),
      );
    }
  }


  @override
  Future<Result<ProfileSimpleModel, Failure>> getUserIdByEmail(String email) async {
    try {
      final response = await _repository.getUserIdByEmail(email);
      final model = mapToProfileSimpleModel(response);
      return Result.success(model);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: toException(e),
          stackTrace: s,
        ),
      );
    }
  }
  @override
  ProfileModel mapToProfileModel(ProfileResponse response) {
    final data = response.data;
    return ProfileModel(
        id: data.id,
        phoneNumber: data.phoneNumber,
        firstName: data.firstName,
        lastName: data.lastName,
        displayName: data.displayName,
        dateOfBirth: data.dateOfBirth,
        gender: data.gender,
        role: data.role,
        avatar: data.avatar,
        status: data.status,
        createdAt: data.createdAt,
        updatedAt: data.updatedAt
    );
  }

  @override
  ProfileSimpleModel mapToProfileSimpleModel(ProfileSimpleResponse response) {
    return ProfileSimpleModel(userId: response.data);
  }







  /*Future<ProfileModel> updateProfile(ProfileModel profile) async {
    final response = await _repository.updateProfile(
      ProfileResponse(
        id: profile.id,
        phoneNumber: profile.phoneNumber,
        address: profile.address,
        firstName: profile.firstName,
        lastName: profile.lastName,
        displayName: profile.displayName,
        dateOfBirth: profile.dateOfBirth,
        gender: profile.gender,
        role: profile.role,
        avatar: profile.avatar,
        status: profile.status,
        createdAt: profile.createdAt,
        updatedAt: profile.updatedAt,
      ),
    );
    return response.toDomain();
  }

  Future<void> updateAvatar(String imagePath) async {
    await _repository.updateAvatar(imagePath);
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    await _repository.changePassword(oldPassword, newPassword);
  }*/
} 