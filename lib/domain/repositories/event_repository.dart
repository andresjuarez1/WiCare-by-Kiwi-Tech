// lib/domain/repositories/user_repository.dart
import 'package:locura1/domain/entities/event.dart';

import '../entities/miniEvent.dart';

abstract class EventRepository {
  Future<void> createEvent(Event event);
  //Future<Minievent> getAllEvents(Minievent event);
  }