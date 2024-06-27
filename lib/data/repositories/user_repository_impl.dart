// lib/data/repositories/user_repository_impl.dart
import 'package:locura1/data/mappers/association_mappers.dart';
import 'package:locura1/domain/entities/volunteer.dart';
import 'package:locura1/domain/entities/association.dart';

import '../../domain/entities/volunteerProfile.dart';
import '../../domain/entities/users.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../mappers/volunteer_mappers.dart';
import '../models/volunteerProfile_model.dart';

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
  @override
  Future<void> registerAssociation(Association association) async {
    final associationModel = associationToAssociationModel(association);
    await remoteDataSource.registerAssociation(associationModel);
  }
  @override
  Future<VolunteerProfile> getUserProfile(int userId, String token) async {
    final profileData = await remoteDataSource.getProfileVolunteer(userId, token);
    return VolunteerProfile.fromJson(profileData);
  }


}