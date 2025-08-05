import 'package:contacts_app/data/datasources/remote/network_service.dart';
import 'package:contacts_app/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> getUserById(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final NetworkService networkService;

  UserRemoteDataSourceImpl(this.networkService);

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      // ✅ Network service'dan dynamic ma'lumot oladi
      final response = await networkService.get('/users');
      
      // ✅ Dynamic'dan UserModel list yasaydi
      if (response is List) {
        return response.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Failed to get users: $e');
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    try {
      final response = await networkService.get('/users/$id');
      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get user $id: $e');
    }
  }
}