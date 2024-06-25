// lib/domain/repositories/user_repository.dart
import 'package:locura1/domain/entities/event.dart';

abstract class EventRepository {
  Future<void> createEvent(Event event);
  }