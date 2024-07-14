// lib/domain/entities/volunteer.dart
class Event {
  final String name;
  final String description;
  final String hour_start;
  final String hour_end;
  final String date;
  final String cathegory;
  final String location;
  final String picture;

  Event({
    required this.name,
    required this.description,
    required this.hour_start,
    required this.hour_end,
    required this.date,
    required this.cathegory,
    required this.location,
    this.picture = '',
  });
}
