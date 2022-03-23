import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_challenge/models/hive_models/models.dart';

class Loading {
  loadBoxes() async {
    await Hive.initFlutter();
    Hive.registerAdapter(StarWarsCharacterAdapter());
    await Hive.openBox<StarWarsCharacter>('starwarsCharacters');

    Hive.registerAdapter(CurrentPageAdapter());
    await Hive.openBox<CurrentPage>('page');
  }
}
