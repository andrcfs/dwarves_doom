import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class GameScene extends Component with HasGameReference<MyGame> {
  @override
  Future<void> onLoad() async {
    final placeholder = RectangleComponent(
      size: Vector2(100, 100),
      paint: Paint()..color = Colors.blue,
      position: game.size / 2 - Vector2(50, 50),
    );
    add(placeholder);
  }
}
