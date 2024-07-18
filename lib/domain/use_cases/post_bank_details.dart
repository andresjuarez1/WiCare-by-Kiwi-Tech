import '../entities/postBankDetails.dart';
import '../repositories/user_repository.dart';

class PostBankDetailsUseCase {
  final UserRepository _userRepository;

  PostBankDetailsUseCase(this._userRepository);

  Future<void> execute(int userId, BankDetails bankDetails, String token) {
    return _userRepository.postBankDetails(userId, bankDetails, token);
  }
}
