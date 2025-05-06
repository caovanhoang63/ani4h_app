import 'package:ani4h_app/features/favorite/data/dto/favorite_response/favorite_response.dart';

abstract interface class IFavoriteRepository {
  // get list of favorite
  Future<FavoriteResponse> getFavorites(int page, int pageSize);
  // add favorite
  Future<void> addFavorite(int id);
  // delete favorite
  Future<void> deleteFavorite(int id);
}