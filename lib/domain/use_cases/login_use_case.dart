import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository_impl.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<String> login({required String email, required String password}) async {
    try {
      final result = await authRepository.login(email, password);
      final data = result['data'];
      String role = data['role'];
      return role;
    } catch (e) {
      throw e; // Re-lanzar cualquier excepción
    }
  }
}
