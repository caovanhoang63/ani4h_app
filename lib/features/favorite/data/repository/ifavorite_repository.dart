import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/features/favorite/data/dto/favorite_response/favorite_response.dart';

abstract interface class IFavoriteRepository {
  // get list of favorite
  Future<FavoriteResponse> getFavorites(String userId, Paging paging);
  // add favorite
  Future<void> addFavorite(String userId, String filmId);
  // delete favorite
  Future<void> deleteFavorite(String userId, String filmId);
}