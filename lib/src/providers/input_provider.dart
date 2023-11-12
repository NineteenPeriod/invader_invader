import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invader_invader/src/models/position.dart';

class InputProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool enablePrint = false;

  double _playerX = 0;
  double _playerY = 0;

  double movementSteps = 0.001;
  double movementSpeed = 1;

  double verticalSpeedIncrease = 2;

  var keysPressed = <int, LogicalKeyboardKey>{};

  addKeyPressed(RawKeyEvent rawKeyEvent) {
    int keyId = rawKeyEvent.logicalKey.keyId;

    // if (keysPressed.length == 2) {
    //   return;
    // }

    if (keysPressed[keyId] == null) {
      dynamicPrint(
          "++++++++++++++++++++ ADD KEY PRESSED ++++++++++++++++++++++++++++");
      keysPressed[keyId] = rawKeyEvent.logicalKey;
    }
    // notifyListeners();
  }

  removeKeyPressed(RawKeyEvent rawKeyEvent) {
    int keyId = rawKeyEvent.logicalKey.keyId;
    dynamicPrint(
        "++++++++++++++++++++ REMOVE KEY  ++++++++++++++++++++++++++++");
    keysPressed.remove(keyId);
    // notifyListeners();
  }

  updatePosition() {
    // TODO: MODIFY TO OPTIMIZE SEARCH
    dynamicPrint(DateTime.now());
    if (keysPressed[LogicalKeyboardKey.keyW.keyId] != null) {
      movePlayerUp();
    }
    if (keysPressed[LogicalKeyboardKey.keyA.keyId] != null) {
      movePlayerLeft();
    }
    if (keysPressed[LogicalKeyboardKey.keyS.keyId] != null) {
      movePlayerDown();
    }
    if (keysPressed[LogicalKeyboardKey.keyD.keyId] != null) {
      movePlayerRight();
    }
    dynamicPrint(DateTime.now());
    dynamicPrint(' ----- NEW Position(x: $_playerX, y: $_playerY) ----- ');
    notifyListeners();
  }

  // void updatePlayerPosition() {
  //   notifyListeners();
  // }

  Position getPosition() {
    return Position(x: _playerX, y: _playerY);
  }

  void movePlayerLeft() {
    if (_playerX > -1.0) {
      _playerX -= (movementSteps * (movementSpeed));
    }
  }

  void movePlayerRight() {
    if (_playerX < 1.0) {
      _playerX += (movementSteps * (movementSpeed));
    }
  }

  void movePlayerUp() {
    if (_playerY > -1.0) {
      _playerY -= (movementSteps * (movementSpeed));
    }
  }

  void movePlayerDown() {
    if (_playerY < 1.0) {
      _playerY += (movementSteps * (movementSpeed));
    }
  }

  void dynamicPrint(Object? object) {
    if (enablePrint) {
      print(object);
    }
  }
}
