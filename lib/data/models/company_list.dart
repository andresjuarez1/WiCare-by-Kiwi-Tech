class CompanyRankingModel {
  final int idCompany;
  final int totalDonations;
  final CompanyModel2 company;

  CompanyRankingModel({
    required this.idCompany,
    required this.totalDonations,
    required this.company,
  });

  factory CompanyRankingModel.fromJson(Map<String, dynamic> json) {
    return CompanyRankingModel(
      idCompany: json['id_company'],
      totalDonations: json['total_donaciones'],
      company: CompanyModel2.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_company': idCompany,
      'total_donaciones': totalDonations,
      'company': company.toJson(),
    };
  }
}

class CompanyModel2 {
  final int id;
  final String email;
  final String role;
  final String name;
  final String description;
  final String cellphone;
  final LocationModel location;
  final String profilePicture;

  CompanyModel2({
    required this.id,
    required this.email,
    required this.role,
    required this.name,
    required this.description,
    required this.cellphone,
    required this.location,
    required this.profilePicture,
  });

  factory CompanyModel2.fromJson(Map<String, dynamic> json) {
    return CompanyModel2(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      description: json['description'],
      cellphone: json['cellphone'],
      location: LocationModel.fromJson(json['location']),
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'name': name,
      'description': description,
      'cellphone': cellphone,
      'location': location.toJson(),
      'profilePicture': profilePicture,
    };
  }
}

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
