import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invader_invader/src/models/position.dart';

class InputProvider with ChangeNotifier, DiagnosticableTreeMixin {
  double _playerX = 0;
  double _playerY = 0;

  double movementSteps = 0.001;
  double movementSpeed = 30;

  double verticalSpeedIncrease = 2;

  var keysPressed = <PhysicalKeyboardKey>{};

  addKeyPressed(PhysicalKeyboardKey physicalKeyboardKey) {
    if (!keysPressed.contains(physicalKeyboardKey)) {
      print(
          "++++++++++++++++++++ ADD KEY PRESSED ++++++++++++++++++++++++++++");
      keysPressed.add(physicalKeyboardKey);
    }
    // notifyListeners();
  }

  removeKeyPressed(PhysicalKeyboardKey physicalKeyboardKey) {
    print("++++++++++++++++++++ REMOVE KEY  ++++++++++++++++++++++++++++");
    keysPressed.remove(physicalKeyboardKey);
    // notifyListeners();
  }

  updatePosition() {
    // TODO: MODIFY TO OPTIMIZE SEARCH
    if (keysPressed.contains(PhysicalKeyboardKey.keyW)) {
      movePlayerUp();
    }
    if (keysPressed.contains(PhysicalKeyboardKey.keyA)) {
      movePlayerLeft();
    }
    if (keysPressed.contains(PhysicalKeyboardKey.keyS)) {
      movePlayerDown();
    }
    if (keysPressed.contains(PhysicalKeyboardKey.keyD)) {
      movePlayerRight();
    }
    print(' ----- NEW Position(x: $_playerX, y: $_playerY) ----- ');
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
}
