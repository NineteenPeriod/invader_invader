import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  Player({super.key, this.x = 0, this.y = 0});

  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: Container(
        height: 10,
        width: 10,
        color: Colors.redAccent,
      ),
    );
  }
}
