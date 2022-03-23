import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_challenge/providers/main_provider.dart';

import 'package:flutter_challenge/config/box_loading.dart';
import 'package:flutter_challenge/config/theme_config.dart';
import 'package:flutter_challenge/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Loading().loadBoxes();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star Wars',
      theme: theme(),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetailsScreen(),
      },
    );
  }
}
