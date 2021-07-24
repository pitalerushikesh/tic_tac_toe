import 'dart:math';
import "package:flutter/material.dart";
import 'package:tic_tac_toe/components/gameButton.dart';

class Home extends StatefulWidget {
  final bool isBot;
  const Home({
    Key? key,
    required this.isBot,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GameButton> buttonsList = [];
  var player1;
  var player2;
  var activePlayer = 1;
  String displayOh = "O";
  String displayEx = "X";

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    activePlayer = 1;
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
    print("Active " + activePlayer.toString());
    setState(() {
      if (widget.isBot) {
        if (activePlayer == 1) {
          gb.text = displayEx;
          activePlayer = 2;
          player1.add(gb.id);
          GameButton? button = autoPlay();
          if (button != null) {
            button.text = displayOh;
            activePlayer = 1;
            player2.add(button.id);
            button.enabled = false;
          }
        }
      } else {
        if (activePlayer == 1) {
          gb.text = displayEx;
          activePlayer = 2;
          player1.add(gb.id);
        } else {
          gb.text = displayOh;
          activePlayer = 1;
          player2.add(gb.id);
        }
      }
      gb.enabled = false;
      int winner = checkWinner();
    });
  }

  GameButton? autoPlay() {
    var emptyCells = [];
    var list = List.generate(9, (index) => index + 1);
    print(list);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }
    print(emptyCells);
    if (emptyCells.length > 0) {
      var random = Random();
      var randIndex = random.nextInt(emptyCells.length - 1);
      print(randIndex);
      var cellID = emptyCells[randIndex];
      int i = buttonsList.indexWhere((element) => element.id == cellID);
      print(emptyCells);
      return buttonsList[i];
    }
    return null;
  }

  int checkWinner() {
    var winner = -1;

    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }

    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner == -1) {
      if (buttonsList.every((element) => element.text != "")) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("Game Draw"),
              content: Text("Wanna Try Again!"),
              actions: [
                TextButton(
                  onPressed: () {
                    resetGame();
                  },
                  child: Text("Yes"),
                ),
              ],
            );
          },
        );
      }
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("Player 1"),
              content: Text("Congratulations! You Have Won"),
              actions: [
                TextButton(
                  onPressed: () {
                    resetGame();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("Player 2"),
              content: Text("Congratulations! You Have Won"),
              actions: [
                TextButton(
                  onPressed: () {
                    resetGame();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
    return winner;
  }

  void btnReset() {
    setState(() {
      buttonsList = doInit();
    });
  }

  void resetGame() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(fontSize: 30.0),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
                itemCount: buttonsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: buttonsList[index].enabled
                        ? () => playGame(buttonsList[index])
                        : null,
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
          ),
          ElevatedButton(
            onPressed: () {
              btnReset();
            },
            child: Text(
              "Reset",
              style: TextStyle(fontSize: 20.0),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets.all(20.0),
            ),
          ),
        ],
      ),
    );
  }
}
