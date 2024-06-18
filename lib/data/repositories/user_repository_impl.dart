// lib/data/repositories/user_repository_impl.dart
import 'package:flutter/material.dart';
import 'package:locura1/data/models/volunteer_model.dart';
import 'package:locura1/domain/entities/volunteer.dart';
import '../../domain/entities/users.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../mappers/mappers.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> loginUser(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);
    return User(email: userModel.email, role: userModel.role);
  }
  @override
  Future<void> registerVolunteer(Volunteer volunteer) async {
    final volunteerModel = volunteerToVolunteerModel(volunteer);
    await remoteDataSource.registerVolunteer(volunteerModel);
  }
}