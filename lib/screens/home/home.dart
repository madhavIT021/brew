import 'package:brew/models/brew.dart';
import 'package:brew/screens/home/settings_form.dart';
import 'package:brew/screens/home/brew_list.dart';
import 'package:brew/services/auth.dart';
import 'package:brew/services/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew/services/database.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    final Authservice _auth = Authservice();

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseServices(uid: "").brews,
      initialData: [],

      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          title: const Text(
            "Brew",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: ElevatedButton.icon(
            onPressed: () async {
              await  await PushNotificationService.sendNotificationToSelectedDriver( context);
            },
            label: const Text(""),
            icon: const Icon(Icons.person),
          ),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              label: const Text("logout"),
              icon: const Icon(Icons.person),
            ),
            TextButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
            child: const BrewList(),
        ),
      ),
    );
  }
}
