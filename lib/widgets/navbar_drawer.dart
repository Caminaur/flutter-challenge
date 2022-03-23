import 'package:flutter/material.dart';
import 'package:flutter_challenge/providers/main_provider.dart';

class NavbarDrawer extends StatelessWidget {
  const NavbarDrawer({
    Key? key,
    required this.primaryColor,
    required this.provider,
  }) : super(key: key);

  final Color primaryColor;
  final MainProvider provider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 50.0),
          SwitchListTile(
            activeColor: primaryColor,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: primaryColor,
            title: Text("Activar modo online",
                style: TextStyle(fontSize: 20.0, color: primaryColor)),
            value: provider.modoOnline,
            onChanged: (value) async {
              if (ModalRoute.of(context)!.settings.name == 'details') {
                provider.setModoOnline(value);
              } else {
                provider.setModoOnline(value);
                if (value == true) {
                  await provider.loadHive(context);
                }
              }
            },
          ),
          const Image(image: AssetImage("assets/broken.png")),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              "Psss!!!! \nDon't activate it unless you are absolutelly sure that you've seen one of us \nThe internet has been intercepted by the invaders\nBe smart, and be safe",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Image(
            image: AssetImage('assets/starwars_logo.gif'),
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
