import 'package:flame/components.dart';

class NpcConfig {
  final String name;
  final Vector2 size;
  final double speed;
  final double hitboxRadius;

  final String idleSpritePath;
  final int idleFrames;
  final String walkSpritePath;
  final int walkFrames;
  final String deathSpritePath;
  final int deathFrames;
  final double stepTime;

  const NpcConfig({
    required this.name,
    required this.size,
    required this.speed,
    required this.hitboxRadius,
    required this.idleSpritePath,
    required this.idleFrames,
    required this.walkSpritePath,
    required this.walkFrames,
    required this.deathSpritePath,
    required this.deathFrames,
    this.stepTime = 0.15,
  });
}

class Npcs {
  static final basicNpc = NpcConfig(
    name: 'Knight',
    size: Vector2.all(16),
    speed: 40,
    hitboxRadius: 6,
    idleSpritePath: 'rogue/idle.png',
    idleFrames: 4,
    walkSpritePath: 'rogue/walk.png',
    walkFrames: 6,
    deathSpritePath: 'rogue/death.png',
    deathFrames: 6,
  );

  static final fastNpc = NpcConfig(
    name: 'Fast Npc',
    size: Vector2.all(32),
    speed: 85,
    hitboxRadius: 6,
    idleSpritePath: 'fast_npc_idle.png',
    idleFrames: 4,
    walkSpritePath: 'fast_npc_walk.png',
    walkFrames: 6,
    deathSpritePath: 'fast_npc_death.png',
    deathFrames: 5,
  );
}
