import 'package:baseflutter/data/models/user_model.dart';
import 'package:baseflutter/data/sources/remote/client/api_client.dart';

class UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSource({required this.apiClient});

  Future<List<UserModel>?> getUsers() async {
    return apiClient.getUsers();
  }
}
