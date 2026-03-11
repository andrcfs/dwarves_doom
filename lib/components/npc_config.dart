import 'package:flame/components.dart';

class NpcConfig {
  final String name;
  final double speed;
  final Vector2 npcSize;
  final String idleSpritePath;
  final int idleFrames;
  final Vector2 idleSize;

  final String walkSpritePath;
  final int walkFrames;
  final Vector2 walkSize;

  final String deathSpritePath;
  final int deathFrames;
  final Vector2 deathSize;

  final double stepTime;

  const NpcConfig({
    required this.name,
    required this.speed,
    required this.npcSize,
    required this.idleSpritePath,
    required this.idleFrames,
    required this.idleSize,
    required this.walkSpritePath,
    required this.walkFrames,
    required this.walkSize,
    required this.deathSpritePath,
    required this.deathFrames,
    required this.deathSize,
    this.stepTime = 0.15,
  });
}

class Npcs {
  static final basicNpc = NpcConfig(
    name: 'Knight',
    speed: 20,
    npcSize: Vector2.all(16),
    idleSpritePath: 'knight/idle.png',
    idleFrames: 4,
    idleSize: Vector2.all(32),
    walkSpritePath: 'knight/walk.png',
    walkFrames: 6,
    walkSize: Vector2(64, 32),
    deathSpritePath: 'knight/death.png',
    deathFrames: 6,
    deathSize: Vector2.all(32),
  );

  static final fastNpc = NpcConfig(
    name: 'Fast Npc',
    speed: 85,
    npcSize: Vector2.all(16),
    idleSpritePath: 'fast_npc_idle.png',
    idleFrames: 4,
    idleSize: Vector2.all(32),
    walkSpritePath: 'fast_npc_walk.png',
    walkFrames: 6,
    walkSize: Vector2.all(32),
    deathSpritePath: 'fast_npc_death.png',
    deathFrames: 5,
    deathSize: Vector2.all(32),
  );
}
