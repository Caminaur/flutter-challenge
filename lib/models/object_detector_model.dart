import 'package:flutter_challenge/models/models.dart';

class ObjectDetector {
  /// If T is a List, K is the subtype of the list.
  static String fromJson<T>(dynamic json, T object) {
    if (object == VehicleModel) {
      return json["name"] + json["model"];
    } else if (object == StarShipModel) {
      return json["name"];
    } else if (object == Film) {
      return json["title"];
    } else {
      throw Exception("Unknown class");
    }
  }
}
