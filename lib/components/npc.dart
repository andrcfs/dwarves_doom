import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'wall.dart';

class Npc extends CircleComponent with CollisionCallbacks {
  static final Random _rng = Random();

  final double speed;
  Vector2 _direction = Vector2.zero();

  Npc({required Vector2 position, this.speed = 40})
    : super(
        position: position,
        radius: 6,
        anchor: Anchor.center,
        paint: Paint()..color = Colors.amber,
      );

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
    _pickNewDirection();
  }

  void _pickNewDirection() {
    final angle = _rng.nextDouble() * 2 * pi;
    _direction = Vector2(cos(angle), sin(angle));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _direction * speed * dt;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is WallBlock) {
      _direction = -_direction;
      position += _direction * 2;
      _pickNewDirection();
    }
  }
}
