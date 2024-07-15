class CompanyModel {
  final String name;
  final String foundation_date;
  final String email;
  final String password;
  final String position;
  final String age;
  final String name_manager;
  final String cellphone_manager;
  final String address_manager;
  final String genre;
  final String latitude;
  final String longitude;
  final String latitude_manager;
  final String longitude_manager;
  final String context;
  final String description;
  final String RFC;
  final String cellphone;

  CompanyModel({
    required this.name,
    required this.foundation_date,
    required this.email,
    required this.password,
    required this.position,
    required this.age,
    required this.name_manager,
    required this.cellphone_manager,
    required this.address_manager,
    required this.genre,
    required this.latitude,
    required this.longitude,
    required this.latitude_manager,
    required this.longitude_manager,
    required this.context,
    required this.description,
    required this.RFC,
    required this.cellphone,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'],
      foundation_date: json['foundation_date'],
      email: json['email'],
      password: json['password'],
      position: json['position'],
      age: json['age'],
      name_manager: json['name_manager'],
      cellphone_manager: json['cellphone_manager'],
      address_manager: json['address_manager'],
      genre: json['genre'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      latitude_manager: json['latitude_manager'],
      longitude_manager: json['longitude_manager'],
      context: json['context'],
      description: json['description'],
      RFC: json['RFC'],
      cellphone: json['cellphone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'foundation_date': foundation_date,
      'email': email,
      'password': password,
      'position': position,
      'age': age,
      'name_manager': name_manager,
      'cellphone_manager': cellphone_manager,
      'address_manager': address_manager,
      'genre': genre,
      'latitude': latitude,
      'longitude': longitude,
      'latitude_manager': latitude_manager,
      'longitude_manager': longitude_manager,
      'context': context,
      'description': description,
      'RFC': RFC,
      'cellphone': cellphone,
    };
  }
}
