import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marioquest/screens/home/settings_form.dart';
import 'package:marioquest/services/auth.dart';
import 'package:marioquest/services/database.dart';
import 'package:marioquest/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:marioquest/models/user.dart';
import 'package:marioquest/screens/home/home.dart';

class StartScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.white, Colors.red[100]],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 70.0));

  String _currentName;
  String _currentCharacter;
  int _currentSaved;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            // widget tree

            // child: Scaffold(
            return Scaffold(
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
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.emoji_events_outlined),
                      title: Text('Champion list'),
                      tileColor: Colors.white60,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        color: Colors.transparent,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/red_button.PNG'),
                          backgroundColor: Colors.red[700],
                          radius: 20,
                          child: Container(
                            child: TextButton(
                              child: Text(
                                'Save the PRINCESS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  foreground: new Paint()
                                    ..shader = linearGradient,
                                  fontSize: 30.0,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'Bangers',
                                ),
                              ),
                              onPressed: () async {
                                _currentSaved = userData.saved + 1;

                                //showAlertDialog
                                //

                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                        _currentCharacter ?? userData.character,
                                        _currentName ?? userData.name,
                                        _currentSaved ?? userData.saved);

                                print('It is pressed');
                                // print(_currentSaved);
                                // print(userData.saved);
                                //

                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Congratulations!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 30.0,
                                          fontFamily: 'Bangers',
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                              'You have now saved the princess:',
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              '$_currentSaved',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.amber,
                                                fontSize: 30.0,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: 'Bangers',
                                              ),
                                            ),
                                            Text(
                                              'time(s)',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'Amazing!',
                                            style: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.grey[700],
                                              fontFamily: 'Bangers',
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          } // )
        });
  }
}
