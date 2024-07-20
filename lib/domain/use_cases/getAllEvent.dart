import 'package:locura1/domain/repositories/event_repository.dart';

import '../entities/associationProfile.dart';
import '../entities/miniEvent.dart';
import '../repositories/user_repository.dart';

class GetAllEventUseCase {
  final EventRepository repository;

  GetAllEventUseCase(this.repository);

  Future<Minievent> call( String token) async {
    return repository.getAllEvents(token as Minievent);
  }
}