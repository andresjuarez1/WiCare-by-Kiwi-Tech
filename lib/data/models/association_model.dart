// lib/data/models/association_model.dart
class AssociationModel {
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
  final String address;
  final String social_reason;
  final String description;
  final String RFC;
  final String cellphone;



  AssociationModel({
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
    required this.address,
    required this.social_reason,
    
    required this.description,
    required this.RFC,
    required this.cellphone,
  });

  factory AssociationModel.fromJson(Map<String, dynamic> json) {
    return AssociationModel(
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
      address: json['address'],
      social_reason: json['social_reason'],
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
      'address': address,
      'social_reason': social_reason,
      'description': description,
      'RFC': RFC,
      'cellphone': cellphone,
    };
  }
}
