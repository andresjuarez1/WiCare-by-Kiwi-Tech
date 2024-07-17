class ProfileCompanyModel {
  final String name;
  final String cellphone;
  final String location;
  final String description;
  final String email;

  ProfileCompanyModel({
    required this.name,
    required this.cellphone,
    required this.location,
    required this.description,
    required this.email,
  });

  factory ProfileCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProfileCompanyModel(
      name: json['name'],
      cellphone: json['cellphone'],
      location: json['location'],
      description: json['description'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cellphone': cellphone,
      'occupation': location,
      'description': description,
      'email': email,
    };
  }
}
  