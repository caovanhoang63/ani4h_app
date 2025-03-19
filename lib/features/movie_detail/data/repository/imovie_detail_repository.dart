import 'package:ani4h_app/features/movie_detail/data/dto/login_request/login_request.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/login_response/login_response.dart';

import '../dto/users_response/users_response.dart';

abstract interface class IMovieDetailRepository {
  Future<UsersResponse> getUsers(int page, int pageSize);
  Future<LoginResponse> login(LoginRequest request);
}