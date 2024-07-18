import '../entities/bankDetails.dart';
import '../repositories/user_repository.dart';

class GetBankDetailsUseCase {
  final UserRepository repository;

  GetBankDetailsUseCase(this.repository);

  Future<BankDetails> call(int userId, String token) {
    return repository.getBankDetails(userId, token); 
  }
}

