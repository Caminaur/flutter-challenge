import 'package:flutter_challenge/models/hive_models/models.dart';
import 'package:flutter_challenge/models/models.dart';
import 'package:flutter_challenge/models/object_detector_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class SwapiDevApi {
  final String _baseUrl = 'swapi.dev';
  // ignore: prefer_typing_uninitialized_variables
  var client;

  openClient() {
    client = http.Client();
  }

  closeClient() {
    client.close();
  }

  Future<String> _getJsonData(String endpoint, [page = 0]) async {
    if (page != 0) {
      final url = Uri.https(_baseUrl, endpoint, {"page": "$page"});
      final response = await client.get(url);
      return response.body;
    }
    final url = Uri.https(_baseUrl, endpoint);
    final response = await client.get(url);
    return response.body;
  }

  Future<List<People>> getMovieCharacters(context, [pagina = 0]) async {
    final jsonData = await _getJsonData('api/people', pagina);
    final response = PersonajesLista.fromJson(jsonData);

    Box pageBox = Hive.box<CurrentPage>('page');
    final currentPage = (response.next != null)
        ? int.parse(response.next!.split('=')[1]) - 1
        : 0;

    final page =
        CurrentPage(page: currentPage, pageCount: response.results!.length);
    pageBox.put('page', page);
    return response.results!;
  }

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

  Future<List<String>> getArray<T>(List<String> urlList, T object) async {
    List<String> array = [];

    for (String string in urlList) {
      String number = string.split('/')[5];
      String type = string.split('/')[4];
      String endpoint = "api/$type/$number";
      final url = Uri.https(_baseUrl, endpoint);
      final response = await client.get(url);

      final jsonData = response.body;
      final String finalResponse = ObjectDetector.fromJson(jsonData, object);
      array.add(finalResponse);
    }
    return array;
  }
}
