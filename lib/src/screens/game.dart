import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invader_invader/src/entities/player.dart';
import 'package:invader_invader/src/models/position.dart';
import 'package:invader_invader/src/providers/input_provider.dart';
import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final bgColor = Colors.black;

  bool isRunning = false;

  double _playerX = 0;
  double _playerY = 0;
  double movementSteps = 0.001;
  double movementSpeed = 30;
  double verticalSpeedIncrease = 2;

  int maxCycles = 10;

  ValueNotifier<bool> _isKeyAPressed = ValueNotifier<bool>(false);

  var keysPressed = <PhysicalKeyboardKey>{};
  final allowedKeys = <PhysicalKeyboardKey>{
    PhysicalKeyboardKey.keyW,
    PhysicalKeyboardKey.keyA,
    PhysicalKeyboardKey.keyS,
    PhysicalKeyboardKey.keyD
  };

  @override
  void initState() {
    // TODO: implement initState
    _setListeners();
    _initGameLoop();
    super.initState();
  }

  void _setListeners() {}

  void _initGameLoop() {
    isRunning = true;

    Timer.periodic(Duration(seconds: 1), (timer) {
      //
      print(" ----- UPDATING POSITION ...  ----- ");
      context.read<InputProvider>().updatePosition();
    });
  }

  _handleInput(FocusNode node, RawKeyEvent event) {
    if (!allowedKeys.contains(event.physicalKey)) {
      return KeyEventResult.ignored;
    }

    if (event is RawKeyDownEvent) {
      if (keysPressed.length == 2) {
        return KeyEventResult.ignored;
      }
      context.read<InputProvider>().addKeyPressed(event.physicalKey);
    } else if (event is RawKeyUpEvent) {
      context.read<InputProvider>().removeKeyPressed(event.physicalKey);
    }

    print("  ----- KEYS PRESSED  ----- ");
    print(context.read<InputProvider>().keysPressed);
    // context.read<InputProvider>().updatePosition();

    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (node, event) => _handleInput(node, event),
      autofocus: true,
      canRequestFocus: true,
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Flexible(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "lvl",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "lives",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Stack(children: [
                    _renderPlayer(context),
                  ])),
              Flexible(
                  flex: 0,
                  child: Text(
                    "Progress",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _renderPlayer(BuildContext context) {
    Position position = context.watch<InputProvider>().getPosition();
    print(" ----- RENDERING PLAYER AT ----- ");
    print(position);
    return Player(
      x: position.x,
      y: position.y,
    );
  }
}
