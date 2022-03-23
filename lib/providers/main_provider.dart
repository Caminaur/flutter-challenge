import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_challenge/api/swapi_dev_api.dart';
import 'package:flutter_challenge/models/models.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_challenge/models/hive_models/models.dart';

class MainProvider extends ChangeNotifier {
  bool loading = false;
  bool loadingBox = false;
  bool modoOnline = false;
  final swapiDevApi = SwapiDevApi();

  List<People> characters = [];
  Map boxCharacters = {};

  Future<void> setModoOnline(bool value) async {
    modoOnline = value;
    notifyListeners();
  }

  Future<void> getNextPage(context) async {
    if (loading) return;
    loading = true;

    swapiDevApi.openClient();
    final pageBox = Hive.box<CurrentPage>('page').get('page');
    Box charactersBox = Hive.box<StarWarsCharacter>('starwarsCharacters');
    final page = pageBox!.page;
    if (page == 0) {
      swapiDevApi.closeClient();
      return;
    }
    characters =
        await swapiDevApi.getMovieCharacters(context, pageBox.page + 1);
    pageBox.page = pageBox.page + 1;
    for (int i = 0; i < characters.length; i++) {
      final sc = characters[i];
      charactersBox.add(await loadCharacter(sc));
      boxCharacters = charactersBox.toMap();
    }
    swapiDevApi.closeClient();
    loading = false;
    boxCharacters = charactersBox.toMap();
    notifyListeners();
  }

  Future loadHive(context) async {
    loading = true;
    int skip = 0;
    notifyListeners();
    Box charactersBox = Hive.box<StarWarsCharacter>('starwarsCharacters');
    final pageBox = Hive.box<CurrentPage>('page').get('page');
    if (charactersBox.isNotEmpty) {
      if (pageBox != null && charactersBox.length != pageBox.pageCount) {
        skip = pageBox.pageCount - charactersBox.length;
      } else {
        boxCharacters = charactersBox.toMap();
        notifyListeners();
        return;
      }
    }

    if (characters.isEmpty) {
      swapiDevApi.openClient();
      notifyListeners();
      characters = await swapiDevApi.getMovieCharacters(context);
    }

    for (int i = 0 + skip; i < characters.length; i++) {
      final sc = characters[i];
      charactersBox.add(await loadCharacter(sc));
      boxCharacters = charactersBox.toMap();
    }
    swapiDevApi.closeClient();
    loading = false;
    boxCharacters = charactersBox.toMap();
    notifyListeners();
  }

  Future<StarWarsCharacter> loadCharacter(People sc) async {
    List<String> films =
        (sc.films.isEmpty) ? [] : await swapiDevApi.getFilmsArray(sc.films);
    List<String> vehicles = (sc.vehicles.isEmpty)
        ? []
        : await swapiDevApi.getVehiclesArray(sc.vehicles);
    List<String> starships = (sc.starships.isEmpty)
        ? []
        : await swapiDevApi.getStarshipsArray(sc.starships);
    String homeworld = await swapiDevApi.getHomeWorld(sc.homeworld);
    final character = StarWarsCharacter(
      name: sc.name,
      height: sc.height,
      mass: sc.mass,
      hairColor: sc.hairColor,
      skinColor: sc.skinColor,
      eyeColor: sc.eyeColor,
      birthYear: sc.birthYear,
      gender: sc.gender.name,
      homeworld: homeworld,
      films: films,
      species: sc.species,
      vehicles: vehicles,
      starships: starships,
      created: sc.created,
      edited: sc.edited,
      url: sc.url,
    );
    return character;
  }

  Future<Map> sendReport(StarWarsCharacter character) async {
    String endpoint = "/posts";
    String number = character.url.split('/')[5];
    final url = Uri.https("jsonplaceholder.typicode.com", endpoint);
    final response = await http.post(
      url,
      body: {
        'userId': number,
        'dateTime': DateTime.now().toString(),
        'character_name': character.name,
      },
    );
    final rs = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        "message":
            "El avisatamiento de ${character.name} fue reportado a las autoridades correspondientes",
        "status": true,
        "id": rs['id'],
        "dateTime": rs['dateTime'],
      };
    } else {
      return {"message": "Error: Algo salio mal", "status": false};
    }
  }
}
