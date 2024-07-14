// lib/domain/repositories/user_repository.dart
import 'dart:io';

import 'package:locura1/domain/entities/event.dart';

import '../entities/miniEvent.dart';

abstract class EventRepository {
  Future<void> createEvent(Event event, File imageFile);
  //Future<Minievent> getAllEvents(Minievent event);
  }