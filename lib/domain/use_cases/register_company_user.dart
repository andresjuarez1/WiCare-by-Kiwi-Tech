// lib/domain/use_cases/register_volunteer_use_case.dart
import 'package:locura1/domain/entities/company.dart';
import '../repositories/user_repository.dart';

class RegisterCompanyUseCase {
  final UserRepository repository;

  RegisterCompanyUseCase(this.repository);

  Future<void> execute(Company company) {
    return repository.registerCompany(company);
  }
}