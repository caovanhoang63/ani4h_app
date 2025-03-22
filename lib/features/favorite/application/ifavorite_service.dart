import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/favorite/domain/model/favorite_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IFavoriteService {
  Future<Result<List<FavoriteModel>, Failure>> getFavorites(int page, int pageSize);
  Future<Result<bool, Failure>> addFavorite(int id);
  Future<Result<bool, Failure>> removeFavorite(int id);
}