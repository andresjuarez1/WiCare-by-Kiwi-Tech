// lib/domain/repositories/user_repository.dart
import '../entities/association.dart';
import '../entities/users.dart';
import '../entities/volunteer.dart';

abstract class UserRepository {
  Future<User> loginUser(String email, String password);
  Future<void> registerVolunteer(Volunteer volunteer);
  Future<void> registerAssociation(Association association);

}