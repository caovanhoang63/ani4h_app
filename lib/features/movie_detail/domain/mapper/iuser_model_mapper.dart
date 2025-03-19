import '../../data/dto/users_response/users_response.dart';
import '../model/user_model.dart';

abstract class IUserModelMapper {
  List<UserModel> mapToUserModel(UsersResponse response);
}