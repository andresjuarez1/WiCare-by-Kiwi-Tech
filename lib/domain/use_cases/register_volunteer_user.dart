import '../entities/volunteer.dart';
import '../repositories/user_repository.dart';

class RegisterVolunteerUseCase {
  final UserRepository repository;

  RegisterVolunteerUseCase(this.repository);

  Future<void> execute(Volunteer volunteer) {
    return repository.registerVolunteer(volunteer);
  }
}
