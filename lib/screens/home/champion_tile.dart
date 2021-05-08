import 'package:flutter/material.dart';
import 'package:marioquest/models/champion.dart';

class ChampionTile extends StatelessWidget {
  final Champion champion;
  String currentimage;
  ChampionTile({this.champion});

  @override
  Widget build(BuildContext context) {
    // print('Current character number is ' + champion.character);
    // big if check
    if (champion.character == '0') {
      currentimage = 'assets/icon_mario.png';
    } else if (champion.character == '1') {
      currentimage = 'assets/icon_luigi.png';
    } else if (champion.character == '2') {
      currentimage = 'assets/icon_wario.png';
    } else if (champion.character == '3') {
      currentimage = 'assets/icon_boo.png';
    } else if (champion.character == '4') {
      currentimage = 'assets/icon_toad.png';
    } else if (champion.character == '5') {
      currentimage = 'assets/icon_yoshi.png';
    } else {
      currentimage = 'assets/icon_toad.png';
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: Image.asset(currentimage, width: 50),
          title: Text(
            champion.name,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Saved the princess ${champion.saved} time(s)',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
              // fontWeight: FontWeight.bold,
              fontFamily: 'Arial',
            ),
          ),
        ),
      ),
    );
  }
}
