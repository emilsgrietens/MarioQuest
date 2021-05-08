import 'package:flutter/material.dart';
import 'package:marioquest/models/champion.dart';
import 'package:provider/provider.dart';
import 'package:marioquest/screens/home/champion_tile.dart';

class ChampionList extends StatefulWidget {
  @override
  _ChampionListState createState() => _ChampionListState();
}

class _ChampionListState extends State<ChampionList> {
  @override
  Widget build(BuildContext context) {
    final champions = Provider.of<List<Champion>>(context) ?? [];
    final ScrollController _scrollController = ScrollController();

    // champions.forEach((champion) {
    //   print(champion.name);
    //   print(champion.character);
    //   print(champion.saved);
    // });

    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: champions.length,
        itemBuilder: (context, index) {
          champions.sort((a, b) => b.saved.compareTo(a.saved));
          return ChampionTile(champion: champions[index]);
        },
      ),
    );
  }
}
