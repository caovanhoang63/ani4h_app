import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/favorite/domain/model/favorite_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IFavoriteService {
  Future<Result<List<FavoriteModel>, Failure>> getFavorites(String userId, Paging paging);
  Future<Result<bool, Failure>> addFavorite(int id);
  Future<Result<bool, Failure>> deleteFavorite(int id);
}