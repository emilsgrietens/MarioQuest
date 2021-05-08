import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marioquest/screens/home/settings_form.dart';
import 'package:marioquest/services/auth.dart';
import 'package:marioquest/services/database.dart';
import 'package:provider/provider.dart';
import 'package:marioquest/screens/home/champion_list.dart';
import 'package:marioquest/models/champion.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.amber[400],
                elevation: 0.0,
                title: Text('MarioQuest'),
                actions: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close),
                    label: Text('Close'),
                    style: TextButton.styleFrom(primary: Colors.grey[700]),
                  ),
                ],
              ),
              body: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Champion>>.value(
      value: DatabaseService().champions,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('MarioQuest'),
          backgroundColor: Colors.amber[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              icon: Icon(Icons.person),
              style: TextButton.styleFrom(primary: Colors.grey[700]),
              label: Text('Profile'),
              onPressed: () => _showSettingsPanel(),
            ),
            TextButton.icon(
              icon: Icon(Icons.logout),
              style: TextButton.styleFrom(primary: Colors.grey[700]),
              label: Text('Leave'),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ChampionList(),
        ), // column & row children
      ),
    );
  }
}
