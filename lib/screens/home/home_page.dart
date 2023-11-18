import 'package:flutter/material.dart';
import '../../models/game.dart';
import '../../repositories/game_reposoty.dart';
import 'add_game.dart';
import 'list_game.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Game>? _game;
  var _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getGame();
  }

  getGame() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var games = await GameRepository().getGame();
      debugPrint('Number of game: ${games.length}');

      setState(() {
        _game = games;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    buildError() => Center(
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_errorMessage ?? '', textAlign: TextAlign.center),
              SizedBox(height: 32.0),
              ElevatedButton(onPressed: getGame, child: Text('Retry'))
            ])));

    buildList() => ListView.builder(
        itemCount: _game!.length,
        itemBuilder: (ctx, i) {
          Game game = _game![i];
          return GameList(game: game);
        });

    handleClickAdd() {
      Navigator.pushNamed(context, AddgamePage.routeName).whenComplete(() {
        getGame();
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Review Game'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: handleClickAdd, child: Icon(Icons.add)),
        body: Stack(
          children: [
            if (_game?.isNotEmpty ?? false) buildList(),
            if (_errorMessage != null) buildError(),
            if (_isLoading) buildLoadingOverlay()
          ],
        ));
  }
}