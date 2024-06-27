import '../entities/associationProfile.dart';
import '../repositories/user_repository.dart';

class GetassociationprofileUseCase {
  final UserRepository repository;

  GetassociationprofileUseCase(this.repository);

  Future<AssociationProfile> call(int userId, String token) async {
    return repository.getAssociationProfile(userId, token);
  }
}