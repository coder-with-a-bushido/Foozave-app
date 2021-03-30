// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

List<Food> foodFromJson(String str) =>
    List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
  Food({
    required this.location,
    required this.date,
    this.id = '',
    required this.name,
    required this.description,
    required this.expireAt,
    this.v = 0,
  });

  Location location;
  DateTime date;
  String id;
  String name;
  String description;
  DateTime expireAt;
  int v;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        location: Location.fromJson(json["location"]),
        date: DateTime.parse(json["date"]).toLocal(),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        expireAt: DateTime.parse(json["expireAt"]).toLocal(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "name": name,
        "description": description,
        "expireAt": expireAt.toUtc().toIso8601String(),
      };
}

class Location {
  Location({
    required this.coordinates,
  });

  List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
