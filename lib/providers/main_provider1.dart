import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_challenge/models/planets_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_challenge/models/hive_models/models.dart';
import 'package:flutter_challenge/models/people_model.dart';
import 'package:flutter_challenge/models/films_model.dart';
import 'package:flutter_challenge/models/vehicle_model.dart';
import 'package:flutter_challenge/models/starship_model.dart';

class MainProvider extends ChangeNotifier {
  bool loading = false;
  bool loadingBox = false;
  bool modoOnline = false;
  // ignore: prefer_typing_uninitialized_variables
  var client;
  final String _baseUrl = 'swapi.dev';

  List<People> characters = [];
  Map boxCharacters = {};

  Future<void> setModoOnline(bool value) async {
    modoOnline = value;
    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.get(url);
    return response.body;
  }

  Future<void> getMovieCharacters(context) async {
    final jsonData = await _getJsonData('api/people');
    final response = PersonajesLista.fromJson(jsonData);

    Box pageBox = Hive.box<CurrentPage>('page');
    final currentPage = int.parse(response.next!.split('=')[1]) - 1;

    final page =
        CurrentPage(page: currentPage, pageCount: response.results!.length);
    pageBox.put('page', page);
    characters = response.results!;
  }

  void getNextPage() {}

  Future<List<String>> getFilmsArray(List<String> filmsUrl) async {
    List<String> array = [];
    for (String filmUrl in filmsUrl) {
      String number = filmUrl.split('/')[5];
      String endpoint = "api/films/$number";
      final url = Uri.https("swapi.dev", endpoint);
      final response = await client.get(url);
      final jsonData = response.body;
      final finalResponse = Film.fromJson(jsonData).title;
      array.add(finalResponse);
    }
    return array;
  }

  Future<List<String>> getStarshipsArray(List<String> starshipsUrl) async {
    List<String> array = [];
    for (String starshipUrl in starshipsUrl) {
      String number = starshipUrl.split('/')[5];
      String endpoint = "api/starships/$number";
      final url = Uri.https(_baseUrl, endpoint);
      final response = await client.get(url);
      final jsonData = response.body;
      final r = StarShipModel.fromJson(jsonData);
      array.add(r.name + r.model);
    }
    return array;
  }

  Future<String> getHomeWorld(String homeWorldUrl) async {
    String number = homeWorldUrl.split('/')[5];
    String endpoint = "api/planets/$number";
    final url = Uri.https(_baseUrl, endpoint);
    final response = await client.get(url);
    final jsonData = response.body;
    final r = Planet.fromJson(jsonData).name;

    return r;
  }

  Future<List<String>> getVehiclesArray(List<String> vehicleUrl) async {
    List<String> array = [];
    for (String vehicleUrl in vehicleUrl) {
      String number = vehicleUrl.split('/')[5];
      String endpoint = "api/vehicles/$number";
      final url = Uri.https(_baseUrl, endpoint);
      final response = await client.get(url);
      final jsonData = response.body;
      final finalResponse = VehicleModel.fromJson(jsonData);
      array.add(finalResponse.name + finalResponse.model);
    }
    return array;
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
      client = http.Client();
      notifyListeners();
      await getMovieCharacters(context);
    }

    for (int i = 0 + skip; i < characters.length; i++) {
      final sc = characters[i];
      List<String> films =
          (sc.films.isEmpty) ? [] : await getFilmsArray(sc.films);
      List<String> vehicles =
          (sc.vehicles.isEmpty) ? [] : await getVehiclesArray(sc.vehicles);
      List<String> starships =
          (sc.starships.isEmpty) ? [] : await getStarshipsArray(sc.starships);
      String homeworld = await getHomeWorld(sc.homeworld);
      final character = StarWarsCharacter(
        name: sc.name,
        height: sc.height,
        mass: sc.mass,
        hairColor: sc.hairColor,
        skinColor: sc.skinColor,
        eyeColor: sc.eyeColor,
        birthYear: sc.birthYear,
        gender: sc.gender.toString(),
        homeworld: homeworld,
        films: films,
        species: sc.species,
        vehicles: vehicles,
        starships: starships,
        created: sc.created,
        edited: sc.edited,
        url: sc.url,
      );
      charactersBox.add(character);
      boxCharacters = charactersBox.toMap();
    }
    loading = false;
    boxCharacters = charactersBox.toMap();
    client.close();
    notifyListeners();
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
