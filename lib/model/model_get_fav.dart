class Datum {
  int id;
  String name;
  String species;
  String gender;
  String origin;
  String location;
  String image;

  Datum({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        species: json["species"],
        gender: json["gender"],
        origin: json["origin"],
        location: json["location"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "species": species,
        "gender": gender,
        "origin": origin,
        "location": location,
        "image": image,
      };
}
