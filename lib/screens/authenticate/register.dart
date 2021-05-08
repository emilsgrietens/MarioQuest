import 'package:flutter/material.dart';
import 'package:marioquest/services/auth.dart';
import 'package:marioquest/shared/constants.dart';
import 'package:marioquest/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.amber[400],
              elevation: 0.0,
              title: Text('MarioQuest'),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign in'),
                  style: TextButton.styleFrom(primary: Colors.grey[700]),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 50.0),
                      // question block image
                      Container(
                        child: Image.asset(
                          'assets/question_block.png',
                          height: 130.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Sign in title
                      Container(
                        child: Text(
                          'Join the MarioQuest:',
                          style: TextStyle(
                            fontFamily: 'Lancelot',
                            fontSize: 30,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // email field
                      TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter email address' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          }),
                      SizedBox(height: 20.0),
                      //password field
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ characters long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.amber[400]),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please supply a valid email!';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: 'Lancelot',
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
