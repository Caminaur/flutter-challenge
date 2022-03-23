import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/hive_models/starwars_character.dart';
import 'package:flutter_challenge/providers/main_provider.dart';
import 'package:flutter_challenge/widgets/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    final box = Hive.box<StarWarsCharacter>('starwarsCharacters').toMap();
    if (box.isNotEmpty) {
      provider.boxCharacters = box;
    }
    final primaryColor = Theme.of(context).primaryColor;
    final headerStyle = Theme.of(context).textTheme.headline3;
    final rowStyle = Theme.of(context).textTheme.headline5;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Wanted Criminals", style: TextStyle(fontSize: 25.0)),
            Icon(Icons.ac_unit),
          ],
        ),
      ),
      drawer: NavbarDrawer(primaryColor: primaryColor, provider: provider),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowHeader(headerStyle: headerStyle),
          const SizedBox(height: 30),
          (provider.boxCharacters.isEmpty)
              ? (provider.loading == true)
                  ? Column(
                      children: [
                        const Image(image: AssetImage('assets/cp.gif')),
                        const SizedBox(height: 20),
                        Text("Loading... please wait",
                            style:
                                TextStyle(fontSize: 20.0, color: primaryColor)),
                      ],
                    )
                  : const Center(
                      child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Text(
                          'No hay resultado, se debe primero ingresar al modo online',
                          style: TextStyle(fontSize: 20.0)),
                    ))
              : CharactersList(
                  box: provider.boxCharacters,
                  rowStyle: rowStyle!,
                  getNextPage: provider.getNextPage,
                ),
        ],
      ),
    );
  }
}
