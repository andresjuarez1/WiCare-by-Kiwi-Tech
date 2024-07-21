class Association {
  final int id;
  final String email;
  final String role;
  final String name;
  final String description;
  final String cellphone;
  final double latitude;
  final double longitude;
  final String profilePicture;
  final Bank? bank;

  Association(
      {required this.id,
      required this.email,
      required this.role,
      required this.name,
      required this.description,
      required this.cellphone,
      required this.latitude,
      required this.longitude,
      required this.profilePicture,
      required this.bank});

  factory Association.fromJson(Map<String, dynamic> json) {
    return Association(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      description: json['description'],
      cellphone: json['cellphone'],
      latitude: (json['location']['latitude'] as num).toDouble(),
      longitude: (json['location']['longitude'] as num).toDouble(),
      profilePicture: json['profilePicture'],
      bank: json['bank'] != null ? Bank.fromJson(json['bank']) : null,
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
      'latitude': latitude,
      'longitude': longitude,
      'profilePicture': profilePicture,
      'bank': bank?.toJson(),
    };
  }
}

class Bank {
  final String name;
  final int number;
  final String bank;
  final int association_id;

  Bank({
    required this.name,
    required this.number,
    required this.bank,
    required this.association_id,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'],
      number: int.tryParse(json['number'].toString()) ?? 0,
      bank: json['bank'],
      association_id: int.tryParse(json['association_id'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'bank': bank,
      'association_id': association_id,
    };
  }
}

class EventUnique {
  final int id;
  final String name;
  final String description;
  final double latitude;
  final double? longitude;
  final String hour_start;
  final String? hour_end;
  final String date;
  final String cathegory;
  final String picture;
  final int association_id;
  final Association? association;

  EventUnique({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.hour_start,
    this.hour_end,
    required this.date,
    required this.cathegory,
    this.picture = '',
    this.association_id = 0,
    this.association,
  });

  factory EventUnique.fromJson(Map<String, dynamic> json) {
    return EventUnique(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      hour_start: json['hour_start'],
      hour_end: json['hour_end'],
      date: json['date'],
      cathegory: json['cathegory'],
      picture: json['picture'],
      association_id: json['association_id'],
      association: json['association'] != null
          ? Association.fromJson(json['association'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'hour_start': hour_start,
      'hour_end': hour_end,
      'date': date,
      'cathegory': cathegory,
      'picture': picture,
      'association_id': association_id,
      'association': association?.toJson(),
    };
  }
}
