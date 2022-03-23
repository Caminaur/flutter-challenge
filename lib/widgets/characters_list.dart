import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/hive_models/models.dart';
import 'package:hive/hive.dart';

class CharactersList extends StatefulWidget {
  const CharactersList(
      {Key? key,
      required this.box,
      required this.rowStyle,
      required this.getNextPage})
      : super(key: key);

  final Map box;
  final TextStyle rowStyle;
  final Function getNextPage;

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.getNextPage(context);
      }
    });
    super.initState();
  }

  Box hiveBox = Hive.box<StarWarsCharacter>('starwarsCharacters');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.box.length,
          itemBuilder: (_, int index) {
            final character = widget.box[index];
            if (index == widget.box.length) {
              return Column(
                children: [
                  InkWell(
                    child: CharacterRow(
                        character: character!, rowStyle: widget.rowStyle),
                    onTap: () {
                      Navigator.pushNamed(context, 'details',
                          arguments: character);
                    },
                  ),
                ],
              );
            }
            return InkWell(
              child: CharacterRow(
                  character: character!, rowStyle: widget.rowStyle),
              onTap: () {
                Navigator.pushNamed(context, 'details', arguments: character);
              },
            );
          }),
    );
  }
}

class CharacterRow extends StatelessWidget {
  const CharacterRow({
    Key? key,
    required this.character,
    required this.rowStyle,
  }) : super(key: key);

  final StarWarsCharacter character;
  final TextStyle rowStyle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var width2 = size.width / 5.2;
    return Column(
      children: [
        const Divider(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(left: 9, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: size.width / 5,
                  height: 70,
                  child: Center(
                      child: Text(
                    character.name,
                    style: rowStyle,
                    textAlign: TextAlign.center,
                  ))),
              SizedBox(
                  width: width2,
                  height: 70,
                  child: Center(
                    child: Text(
                        (character.height != 'unknown')
                            ? '${character.height} cm'
                            : character.mass,
                        style: rowStyle),
                  )),
              SizedBox(
                  width: 60,
                  height: 70,
                  child: Center(
                    child: Text(
                      (character.mass != 'unknown')
                          ? '${character.mass} kg'
                          : character.mass,
                      style: rowStyle,
                      textAlign: TextAlign.justify,
                    ),
                  )),
              SizedBox(
                width: width2,
                height: 70,
                child: Center(
                  child: Text(
                    character.gender,
                    style: rowStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
