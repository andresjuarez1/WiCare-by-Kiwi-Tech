import '../entities/volunteerProfile.dart';
import '../repositories/user_repository.dart';

class GetvolunteerprofileUseCase {
  final UserRepository repository;

  GetvolunteerprofileUseCase(this.repository);

  Future<VolunteerProfile> call(int userId, String token) async {
    return repository.getVolunteerProfile(userId, token);
  }
}