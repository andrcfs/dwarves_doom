import 'package:flutter/material.dart';

import '../game.dart';

class HudOverlay extends StatelessWidget {
  final MyGame game;
  const HudOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: game.restartGame,
              child: const Text('Restart'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: game.returnToMenu,
              child: const Text('Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
