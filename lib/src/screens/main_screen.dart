import 'package:flutter/material.dart';
import 'package:invader_invader/src/screens/game.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Invader Invader",
                    style: TextStyle(fontSize: 19),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  FilledButton(
                      onPressed: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Game(),
                              ),
                            )
                          },
                      child: Text("Iniciar"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
