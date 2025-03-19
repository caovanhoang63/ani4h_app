import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/login_request/login_request.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/user_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IMovieDetailService {
  Future<Result<List<UserModel>, Failure>> getUsers(int page, int pageSize);
  Future<Result<bool, Failure>> login(LoginRequest request);
}