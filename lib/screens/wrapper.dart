import 'package:flutter/material.dart';
import 'package:marioquest/screens/home/start.dart';
import 'package:marioquest/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:marioquest/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // retur either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return StartScreen();
      // return Home();
    }
  }
}
