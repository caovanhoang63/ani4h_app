import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/movie_detail/application/imovie_detail_service.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/login_request/login_request.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/users_response/users_response.dart';
import 'package:ani4h_app/features/movie_detail/domain/mapper/iuser_model_mapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import '../data/repository/imovie_detail_repository.dart';
import '../data/repository/movie_detail_repository.dart';
import '../domain/model/user_model.dart';

final movieDetailServiceProvider = Provider<IMovieDetailService>((ref) {
  final movieDetailRepository = ref.watch(movieDetailRepositoryProvider);
  return MovieDetailService(movieDetailRepository);
});

final class MovieDetailService implements IMovieDetailService, IUserModelMapper {
  final IMovieDetailRepository _movieDetailRepository;

  MovieDetailService(this._movieDetailRepository);

  @override
  Future<Result<List<UserModel>, Failure>> getUsers(int page, int pageSize) async {
    try {
      final response = await _movieDetailRepository.getUsers(page, pageSize);

      final models = mapToUserModel(response);

      return Result.success(models);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<Result<bool, Failure>> login(LoginRequest request) async {
    try {
      await _movieDetailRepository.login(request);

      return const Result.success(true);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  List<UserModel> mapToUserModel(UsersResponse response) {
    return response.data.map((e) => UserModel(
      id: e.id,
      phoneNumber: e.phoneNumber,
      firstName: e.firstName,
      lastName: e.lastName,
      displayName: e.displayName,
      dateOfBirth: e.dateOfBirth,
      gender: e.gender,
      role: e.role,
      avatar: e.avatar,
      status: e.status,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    )).toList();
  }
}