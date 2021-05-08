import 'package:flutter/material.dart';
import 'package:marioquest/models/user.dart';
import 'package:marioquest/services/database.dart';
import 'package:marioquest/shared/constants.dart';
import 'package:marioquest/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  List<Map> _myCharacter = [
    {'id': '0', 'image': 'assets/icon_mario.png', 'name': 'Mario'},
    {'id': '1', 'image': 'assets/icon_luigi.png', 'name': 'Luigi'},
    {'id': '2', 'image': 'assets/icon_wario.png', 'name': 'Wario'},
    {'id': '3', 'image': 'assets/icon_boo.png', 'name': 'Boo'},
    {'id': '4', 'image': 'assets/icon_toad.png', 'name': 'Toad'},
    {'id': '5', 'image': 'assets/icon_yoshi.png', 'name': 'Yoshi'},
  ];

  // form values
  String _currentName;
  String _currentCharacter;
  int _currentSaved;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            // widget tree
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Change your name:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      SizedBox(height: 20.0),
                      // dropdown for characters
                      Text(
                        'Choose a different character:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isDense: true,
                              hint: new Text("Select character"),
                              value: _currentCharacter ?? userData.character,
                              items: _myCharacter.map((character) {
                                return DropdownMenuItem(
                                  value: character['id'].toString(),
                                  child: Row(
                                    children: [
                                      Image.asset(character['image'],
                                          width: 50),
                                      Container(
                                          margin: EdgeInsets.only(left: 10),
                                          padding: EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: Text(character['name'])),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) =>
                                  setState(() => _currentCharacter = val),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.amber[400]),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentCharacter ?? userData.character,
                                _currentName ?? userData.name,
                                _currentSaved ?? userData.saved);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                            fontFamily: 'Lancelot',
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
