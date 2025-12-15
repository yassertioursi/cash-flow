import '../../../user/data/model/user_model.dart';

abstract class BaseAuthDataSource {

  Future<UserModel> authenticate(String email, String password);

  Future<UserModel> registerUser(UserModel user);

  Future<UserModel> getLoggedUser();

  Future<void> saveSession(UserModel user);

  Future<void> deleteSession();
}
