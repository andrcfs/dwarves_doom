import 'package:flutter/material.dart';

import '../game.dart';

class MenuOverlay extends StatelessWidget {
  final MyGame game;
  const MenuOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Dwarves' Doom",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: game.startGame,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
            child: const Text('Play', style: TextStyle(fontSize: 24)),
          ),
        ],
      ),
    );
  }
}
