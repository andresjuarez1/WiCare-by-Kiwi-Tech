// lib/domain/repositories/user_repository.dart
import '../entities/users.dart';

abstract class UserRepository {
  Future<User> loginUser(String email, String password);
}
