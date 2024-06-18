// domain/repositories/auth_repository.dart
import '../entities/users.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
}
