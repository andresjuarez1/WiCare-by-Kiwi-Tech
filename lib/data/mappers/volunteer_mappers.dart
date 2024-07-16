
import '../../domain/entities/volunteer.dart';
import '../models/volunteer_model.dart';

VolunteerModel volunteerToVolunteerModel(Volunteer volunteer) {
  return VolunteerModel(
    name: volunteer.name,
    age: volunteer.age,
    curp: volunteer.curp,
    cellphone: volunteer.cellphone,
    postal: volunteer.postal,
    latitude: volunteer.latitude,
    longitude: volunteer.longitude,
    occupation: volunteer.occupation,
    genre: volunteer.genre,
    email: volunteer.email,
    password: volunteer.password,
  );
}

Volunteer volunteerModelToVolunteer(VolunteerModel model) {
  return Volunteer(
    name: model.name,
    age: model.age,
    curp: model.curp,
    cellphone: model.cellphone,
    postal: model.postal,
    latitude: model.latitude,
    longitude: model.longitude,
    occupation: model.occupation,
    genre: model.genre,
    email: model.email,
    password: model.password,
  );
}
