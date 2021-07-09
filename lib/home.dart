import "package:flutter/material.dart";
import 'package:tic_tac_toe/components/gameButton.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GameButton> buttonsList = [];
  var player1;
  var player2;
  var activePlayer;
  String displayOh = "O";
  String displayEx = "X";

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];
    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = displayEx;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = displayOh;
        activePlayer = 2;
        player2.add(gb.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(fontSize: 30.0),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
          itemCount: buttonsList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    buttonsList[index].text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.0,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
