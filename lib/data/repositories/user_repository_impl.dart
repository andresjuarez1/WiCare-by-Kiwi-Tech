import 'dart:io';
import 'package:locura1/data/mappers/association_mappers.dart';
import 'package:locura1/data/mappers/company_mappers.dart';
import 'package:locura1/domain/entities/volunteer.dart';
import 'package:locura1/domain/entities/association.dart';
import '../../domain/entities/associationProfile.dart';
import '../../domain/entities/company.dart';
import '../../domain/entities/companyProfile.dart';
import '../../domain/entities/volunteerProfile.dart';
import '../../domain/entities/users.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../mappers/volunteer_mappers.dart';
import '../../domain/entities/bankDetails.dart';

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
  Future<void> registerCompany(Company company) async {
    final companyModel = companyToCompanyModel(company);
    await remoteDataSource.registerCompany(companyModel);
  }

  @override
  Future<VolunteerProfile> getVolunteerProfile(int userId, String token) async {
    final profileData =
        await remoteDataSource.getProfileVolunteer(userId, token);
    return VolunteerProfile.fromJson(profileData);
  }

  @override
  Future<AssociationProfile> getAssociationProfile(
      int userId, String token) async {
    final profileData =
        await remoteDataSource.getProfileAssociation(userId, token);
    return AssociationProfile.fromJson(profileData);
  }

  @override
  Future<CompanyProfile> getCompanyProfile(int userId, String token) async {
    final profileData = await remoteDataSource.getProfileCompany(userId, token);
    return CompanyProfile.fromJson(profileData);
  }

  @override
  Future<void> updateProfilePicture(
      int userId, File profilePicture, String token) async {
    await remoteDataSource.updateProfilePicture(userId, profilePicture, token);
  }

  @override
  Future<void> postBankDetails(
      int userId, BankDetails bankDetails, String token) async {
    await remoteDataSource.postBankDetails(userId, bankDetails.toJson(), token);
  }

  @override
  Future<BankDetails> getBankDetails(int userId, String token) async {
    final bankDetails = await remoteDataSource.getBankDetails(userId, token);
    return BankDetails.fromJson(bankDetails);
  }
}
