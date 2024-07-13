
import '../../domain/entities/volunteerProfile.dart';
import '../models/volunteerProfile_model.dart';

// Convierte un objeto Profile a ProfileModel
ProfileVolunteerModel profileToProfileModel(VolunteerProfile profile) {
  return ProfileVolunteerModel(
    name: profile.name,
    cellphone: profile.cellphone,
    occupation: profile.occupation,
    genre: profile.genre,
    email: profile.email,
    profilePicture : profile.profilePicture
  );
}

// Convierte un objeto ProfileModel a Profile
VolunteerProfile profileModelToProfile(ProfileVolunteerModel profileModel) {
  return VolunteerProfile(
    name: profileModel.name,
    cellphone: profileModel.cellphone,
    occupation: profileModel.occupation,
    genre: profileModel.genre,
    email: profileModel.email,
      profilePicture : profileModel.profilePicture,
  );
}
