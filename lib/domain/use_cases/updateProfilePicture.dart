import 'dart:io';

import '../repositories/user_repository.dart';

class UpdateProfilePictureUseCase {
  final UserRepository _userRepository;

  UpdateProfilePictureUseCase(this._userRepository);

  Future<void> execute(int userId, File profilePicture, String token) async {
    await _userRepository.updateProfilePicture(userId, profilePicture, token);
  }
}
