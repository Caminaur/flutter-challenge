import 'package:hive/hive.dart';

part 'starwars_character.g.dart';

@HiveType(typeId: 3)
class StarWarsCharacter extends HiveObject {
  StarWarsCharacter({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
    required this.created,
    required this.edited,
    required this.url,
  });
  @HiveField(0)
  String name;
  @HiveField(1)
  String height;
  @HiveField(2)
  String mass;
  @HiveField(3)
  String hairColor;
  @HiveField(4)
  String skinColor;
  @HiveField(5)
  String eyeColor;
  @HiveField(6)
  String birthYear;
  @HiveField(7)
  String gender;
  @HiveField(8)
  String homeworld;
  @HiveField(9)
  List<String> films;
  @HiveField(10)
  List<String> species;
  @HiveField(11)
  List<String> vehicles;
  @HiveField(12)
  List<String> starships;
  @HiveField(13)
  DateTime created;
  @HiveField(14)
  DateTime edited;
  @HiveField(15)
  String url;
}
