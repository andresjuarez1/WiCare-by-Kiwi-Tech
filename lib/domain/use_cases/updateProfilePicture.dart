import 'dart:io';

import '../../data/datasources/remote/user_remote_data_source.dart';

class UpdateProfilePictureUseCase {
  final UserRemoteDataSource remoteDataSource;

  UpdateProfilePictureUseCase(this.remoteDataSource);

  Future<void> updateProfilePicture(int userId, File imageFile) async {
    await remoteDataSource.updateProfilePicture(userId, imageFile);
  }
}
