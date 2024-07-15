import '../entities/association.dart';

import '../repositories/user_repository.dart';

class RegisterAssociationUseCase {
  final UserRepository repository;

  RegisterAssociationUseCase(this.repository);

  Future<void> execute(Association association) {
    return repository.registerAssociation(association);
  }
}