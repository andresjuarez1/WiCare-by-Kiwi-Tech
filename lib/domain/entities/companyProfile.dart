class CompanyProfile {
  final String name;
  final String cellphone;
  final Location location;
  final String description;
  final String email;
  final String profilePicture;

  CompanyProfile({
    required this.name,
    required this.cellphone,
    required this.location,
    required this.description,
    required this.email,
    required this.profilePicture,
  });

  factory CompanyProfile.fromJson(Map<String, dynamic> json) {
    return CompanyProfile(
      name: json['name'],
      cellphone: json['cellphone'],
      location: Location.fromJson(json['location']),
      description: json['description'],
      email: json['email'],
      profilePicture: json['profilePicture'],
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
