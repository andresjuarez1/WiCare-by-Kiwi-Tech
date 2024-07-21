import '../../domain/entities/volunteerProfile.dart';
import '../models/volunteerProfile_model.dart';

ProfileVolunteerModel profileToProfileModel(VolunteerProfile profile) {
  return ProfileVolunteerModel(
    name: profile.name,
    cellphone: profile.cellphone,
    occupation: profile.occupation,
    genre: profile.genre,
    email: profile.email,
    profilePicture: profile.profilePicture,
    id: profile.id,
  );
}

VolunteerProfile profileModelToProfile(ProfileVolunteerModel profileModel) {
  return VolunteerProfile(
    name: profileModel.name,
    cellphone: profileModel.cellphone,
    occupation: profileModel.occupation,
    genre: profileModel.genre,
    email: profileModel.email,
    profilePicture: profileModel.profilePicture,
    id: profileModel.id,
  );
}