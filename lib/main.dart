import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic tac toe',
        home: Scaffold(
          backgroundColor: Colors.orange.shade300,
          appBar: AppBar(
            title: Text('Tic tac toe'),
            backgroundColor: Colors.orange.shade300,
          ),
          body: HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonList;

  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonList = initGameButtons();
  }

  List<GameButton> initGameButtons() {
    player1 = [];
    player2 = [];

    activePlayer = 1;

    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];

    return gameButtons;
  }

  void playGame(GameButton gb) {
    print("ACTIVE PLAYER  ${activePlayer}");

    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.green;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "O";
        gb.bg = Colors.red;
        activePlayer = 1;
        player2.add(gb.id);
      }

      gb.enabled = false;

      int winner = checkWinner();

      print("BUTTON NO. ${gb.id}");

      if (winner == -1) {
        if (buttonList.every((element) => element.text != "")) {
          showDialog(
            context: context,
            builder: (_) => CustomDialog(
                "Game Tied", "Press reset button to start again.", resetGame),
          );
        } else {
          //activePlayer == 2 ? autoPlay() : null;
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    print("AUTOPLAY");

    var emptyCells = []; //List()

    var list = List.generate(9, (index) => index + 1);

    for (var cellID in list) {
      if (!player1.contains(cellID) && !player2.contains(cellID)) {
        emptyCells.add(cellID);
        //print("empty cells added :  ${emptyCells.length}");

      }
    }

    var r = Random();

    print("empty cells :  ${emptyCells.length}");

    //var randomIndex = r.nextInt(emptyCells.length > 1 ? emptyCells.length-1 : 1); // może zadziała

    var randomIndex = r.nextInt(emptyCells.length - 1);

    //var randomIndex = r.nextInt(emptyCells.length);

    print("random index :  ${randomIndex}");

    var cellID = emptyCells[randomIndex];

    int i = buttonList.indexWhere((element) => element.id == cellID);
    playGame(buttonList[i]);
  }

  int checkWinner() {
    var winner = -1;

    //wiersze
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }

    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }

    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }

    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    //kolumny

    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }

    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }

    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }

    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //skosy

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

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialog("Player 1 won the game!",
                "Start again ? Press restart", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomDialog("Player 2 won the game!",
                "Start again ? Press restart", resetGame));
      }
    }

    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      setState(() {
        buttonList = initGameButtons();
      });
    } else {
      setState(() {
        buttonList = initGameButtons();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tic Tac Toe"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 9),
                    itemCount: buttonList.length,
                    itemBuilder: (context, i) => SizedBox(
                          width: 100,
                          height: 100,
                          child: RaisedButton(
                            padding: EdgeInsets.all(8),
                            onPressed: buttonList[i].enabled
                                ? () => playGame(buttonList[i])
                                : null,
                            child: Text(
                              buttonList[i].text,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            color: buttonList[i].bg,
                            disabledColor: buttonList[i].bg,
                          ),
                        ))),
            RaisedButton(
              child: Text(
                "reset",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.red,
              padding: EdgeInsets.all(20),
              onPressed: resetGame,
            )
          ],
        ));
  }
}

class CustomDialog extends StatelessWidget {
  final title;

  final content;
  final VoidCallback callback;

  final actionText;

  CustomDialog(this.title, this.content, this.callback,
      [this.actionText = "Reset"]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
            onPressed: callback, color: Colors.white, child: Text(actionText)),
      ],
    );
  }
}

class GameButton {
  final id;
  String text;
  Color bg;
  bool enabled;

  GameButton(
      {this.id, this.text = "", this.bg = Colors.grey, this.enabled = true});
}
