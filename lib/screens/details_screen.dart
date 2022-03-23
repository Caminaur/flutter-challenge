import 'package:flutter/material.dart';
import 'package:flutter_challenge/providers/main_provider.dart';
import 'package:flutter_challenge/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as dynamic;
    final provider = Provider.of<MainProvider>(context);
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () async {
          if (provider.modoOnline == true) {
            final response = await provider.sendReport(character);
            ShowMyDialog().showResponse(context, response, primaryColor);
          } else {
            await ShowMyDialog()
                .showMyDialog(primaryColor, provider, character, context);
          }
        },
        label: Text('Reportar',
            style: TextStyle(fontSize: 25, color: primaryColor)),
      ),
      body: Scaffold(
        appBar: AppBar(
          title: const Text("Star Wars Character"),
        ),
        drawer: NavbarDrawer(primaryColor: primaryColor, provider: provider),
        body: DetailsBody(character: character, color: primaryColor),
      ),
    );
  }
}

class DetailsBody extends StatelessWidget {
  const DetailsBody({
    Key? key,
    required this.character,
    required this.color,
  }) : super(key: key);

  final dynamic character;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final infoStyle = TextStyle(
      fontSize: 18.0,
      color: color,
    );
    final fieldsStyle = TextStyle(
        fontSize: 22.0,
        color: color,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.visible);
    const divider = Divider(
      height: 10,
      color: Color.fromRGBO(255, 232, 31, 1),
      // thickness: 1,
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CharacterDetailsRow(
                fieldsStyle: fieldsStyle,
                characterField: character.name,
                text1: "Name: ",
                text2: "",
                infoStyle: infoStyle),
            divider,
            CharacterDetailsRow(
                fieldsStyle: fieldsStyle,
                characterField: character.homeworld,
                text1: "Homeworld: ",
                text2: "",
                infoStyle: infoStyle),
            divider,
            CharacterDetailsRow(
                fieldsStyle: fieldsStyle,
                characterField: character.height,
                text1: "Height: ",
                text2: " cm",
                infoStyle: infoStyle),
            divider,
            CharacterDetailsRow(
                fieldsStyle: fieldsStyle,
                characterField: character.mass,
                text1: "Weight: ",
                text2: " Kg",
                infoStyle: infoStyle),
            divider,
            CharacterDetailsRow(
                fieldsStyle: fieldsStyle,
                characterField: character.hairColor,
                text1: "Hair color: ",
                text2: "",
                infoStyle: infoStyle),
            divider,
            CharacterDetailsRow(
                fieldsStyle: fieldsStyle,
                characterField: character.skinColor,
                text1: "Skin color: ",
                text2: "",
                infoStyle: infoStyle),
            divider,
            CharacterDetailsRow(
                fieldsStyle: fieldsStyle,
                characterField: character.eyeColor,
                text1: "Eye color: ",
                text2: "",
                infoStyle: infoStyle),
            divider,
            CharacterDetailsRow(
                fieldsStyle: fieldsStyle,
                characterField: character.birthYear,
                text1: "Birthyear: ",
                text2: "",
                infoStyle: infoStyle),
            divider,
            CharacterDetailsRow(
                fieldsStyle: fieldsStyle,
                characterField: character.gender,
                text1: "Gender: ",
                text2: "",
                infoStyle: infoStyle),
            divider,
            Text('Films', style: fieldsStyle),
            ListedItems(listField: character.films, style: infoStyle),
            divider,
            Text('Vehicles', style: fieldsStyle),
            (character.vehicles.isNotEmpty)
                ? ListedItems(listField: character.vehicles, style: infoStyle)
                : Text('Este personaje no tiene vehiculos registrados',
                    style: infoStyle),
            divider,
            Text('Starships', style: fieldsStyle),
            (character.starships.isNotEmpty)
                ? ListedItems(listField: character.starships, style: infoStyle)
                : Text('Este personaje no tiene starhips registradas',
                    style: infoStyle),
            divider,
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class ListedItems extends StatelessWidget {
  const ListedItems({
    Key? key,
    required this.listField,
    required this.style,
  }) : super(key: key);

  final dynamic listField;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listField
            .map<Widget>((field) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(" - $field", style: style),
                ))
            .toList(),
      ),
    );
  }
}

class CharacterDetailsRow extends StatelessWidget {
  const CharacterDetailsRow({
    Key? key,
    required this.fieldsStyle,
    required this.characterField,
    required this.infoStyle,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final TextStyle fieldsStyle;
  final dynamic characterField;
  final String text1;
  final String text2;

  final TextStyle infoStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$text1 ",
            style: fieldsStyle,
          ),
          Text(
            " $characterField $text2",
            style: infoStyle,
          ),
        ],
      ),
    );
  }
}
