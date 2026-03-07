import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game.dart';
import 'overlays/hud.dart';
import 'overlays/menu.dart';

class MyGameWidget extends StatelessWidget {
  const MyGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget<MyGame>.controlled(
      gameFactory: MyGame.new,
      overlayBuilderMap: {
        'menu': (context, game) => MenuOverlay(game: game),
        'hud': (context, game) => HudOverlay(game: game),
      },
      initialActiveOverlays: const ['menu'],
    );
  }
}
