import 'dart:io';

import 'package:locura1/domain/entities/event.dart';
import 'package:locura1/domain/repositories/event_repository.dart';

class CreateEventUseCase {
  final EventRepository repository;

  CreateEventUseCase(this.repository);

  Future<void> execute(Event event, File image) async {
    await repository.createEvent(event, image);
  }
}
