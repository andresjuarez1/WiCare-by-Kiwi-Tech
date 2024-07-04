import '../entities/companyProfile.dart';
import '../repositories/user_repository.dart';

class GetcompanyprofileUseCase {
  final UserRepository repository;

  GetcompanyprofileUseCase(this.repository);

  Future<CompanyProfile> call(int userId, String token) async {
    return repository.getCompanyProfile(userId, token);
  }
}