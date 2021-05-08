import 'package:flutter/material.dart';
import 'package:marioquest/screens/wrapper.dart';
import 'package:marioquest/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:marioquest/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Lancelot'),
        home: Wrapper(),
      ),
    );
  }
}
