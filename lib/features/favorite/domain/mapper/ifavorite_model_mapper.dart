import 'package:ani4h_app/features/favorite/data/dto/favorite_response/favorite_response.dart';
import 'package:ani4h_app/features/favorite/domain/model/favorite_model.dart';

abstract class IFavoriteModelMapper {
  List<FavoriteModel> mapToFavoriteModel(FavoriteResponse response);
}