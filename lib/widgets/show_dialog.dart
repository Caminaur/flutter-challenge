import 'package:flutter/material.dart';
import 'package:flutter_challenge/providers/main_provider1.dart';

Future<dynamic> showMyDialog(Color primaryColor, MainProvider provider,
    character, BuildContext context) async {
  showDialog(
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: primaryColor,
      title: const Text("Activar modo online",
          style: TextStyle(fontSize: 25.0, color: Colors.black)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await provider.setModoOnline(true);
                final respuesta = await provider.sendReport(character);
                showResponse(context, respuesta, primaryColor);
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text('Activar',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: primaryColor,
                    )),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: const Text('Todavía no',
                    style: TextStyle(fontSize: 25.0, color: Colors.black)),
              ),
            ),
          ],
        ),
      ],
    ),
    context: context,
  );
}

Future<dynamic> showResponse(BuildContext context, respuesta, primaryColor) {
  return showDialog(
      builder: (BuildContext context) => AlertDialog(
            backgroundColor: primaryColor,
            title: Text("ID: ${respuesta["id"]}"),
            content: Text(
              respuesta["message"],
              style: const TextStyle(fontSize: 22.0, color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.close, size: 35.0, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
      context: context);
}
