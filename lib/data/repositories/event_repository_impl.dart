import 'dart:io';

import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/remote/event_remote_data_source.dart';
import '../mappers/event_mappers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource remoteDataSource;

  EventRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createEvent(Event event, File image) async {
    await remoteDataSource.createEvent(event, image);
  }

}