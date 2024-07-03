// To parse this JSON data, do
//
//     final modelGetAllCharacter = modelGetAllCharacterFromJson(jsonString);

import 'dart:convert';

ModelGetAllCharacter modelGetAllCharacterFromJson(String str) =>
    ModelGetAllCharacter.fromJson(json.decode(str));

String modelGetAllCharacterToJson(ModelGetAllCharacter data) =>
    json.encode(data.toJson());

class ModelGetAllCharacter {
  List<Result> results;

  ModelGetAllCharacter({
    required this.results,
  });

  factory ModelGetAllCharacter.fromJson(Map<String, dynamic> json) =>
      ModelGetAllCharacter(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  String name;
  String species;
  String gender;
  Location origin;
  Location location;
  String image;

  Result({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        species: json["species"],
        gender: json["gender"],
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "species": species,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
      };
}

class Location {
  String name;
  

  Location({
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
