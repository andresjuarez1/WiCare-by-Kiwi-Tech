class VolunteerModel {
  final String name;
  final String age;
  final String curp;
  final String cellphone;
  final String postal;
  // final String address;
  final String latitude;
  final String longitude;
  final String occupation;
  final String genre;
  final String email;
  final String password;

  VolunteerModel({
    required this.name,
    required this.age,
    required this.curp,
    required this.cellphone,
    required this.postal,
    // required this.address,
    required this.latitude,
    required this.longitude,
    required this.occupation,
    required this.genre,
    required this.email,
    required this.password,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) {
    return VolunteerModel(
      name: json['name'],
      age: json['age'],
      curp: json['curp'],
      cellphone: json['cellphone'],
      postal: json['postal'],
      // address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      occupation: json['occupation'],
      genre: json['genre'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'curp': curp,
      'cellphone': cellphone,
      'postal': postal,
      'latitude': latitude,
      'longitude': longitude,
      'occupation': occupation,
      'genre': genre,
      'email': email,
      'password': password,
    };
  }
}
