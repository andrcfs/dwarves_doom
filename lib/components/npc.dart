import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'npc_config.dart';
import 'wall.dart';

enum NpcState { idle, walk, death }

class Npc extends SpriteAnimationGroupComponent<NpcState>
    with CollisionCallbacks, HasGameReference {
  static final Random _rng = Random();

  final NpcConfig config;
  Vector2 _direction = Vector2.zero();

  late final RectangleHitbox _hitbox;

  double _stateTimer = 0;
  final double _stateDuration = 2.0;

  Npc({required Vector2 position, required this.config})
    : super(position: position, size: config.npcSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final idleImage = await game.images.load(config.idleSpritePath);
    final walkImage = await game.images.load(config.walkSpritePath);
    final deathImage = await game.images.load(config.deathSpritePath);

    SpriteAnimation createAnimation(
      dynamic image,
      int frames,
      Vector2 textureSize,
    ) {
      return SpriteAnimation.fromFrameData(
        image,
        SpriteAnimationData.sequenced(
          amount: frames,
          stepTime: config.stepTime,
          textureSize: textureSize,
        ),
      );
    }

    animations = {
      NpcState.idle: createAnimation(
        idleImage,
        config.idleFrames,
        config.idleSize,
      ),
      NpcState.walk: createAnimation(
        walkImage,
        config.walkFrames,
        config.walkSize,
      ),
      NpcState.death: createAnimation(
        deathImage,
        config.deathFrames,
        config.deathSize,
      ),
    };

    // Initialize the hitbox with a center anchor
    _hitbox = RectangleHitbox(anchor: Anchor.center);
    add(_hitbox);

    _changeState(NpcState.idle);
    _pickNewDirection();
  }

  void _changeState(NpcState newState) {
    if (current == newState) return;

    current = newState;

    final scaleX = config.npcSize.x / config.idleSize.x;
    final scaleY = config.npcSize.y / config.idleSize.y;

    switch (newState) {
      case NpcState.idle:
        size = Vector2(config.idleSize.x * scaleX, config.idleSize.y * scaleY);
        break;
      case NpcState.walk:
        size = Vector2(config.walkSize.x * scaleX, config.walkSize.y * scaleY);
        break;
      case NpcState.death:
        size = Vector2(
          config.deathSize.x * scaleX,
          config.deathSize.y * scaleY,
        );
        break;
    }

    _hitbox.position = size / 2;
  }

  void _pickNewDirection() {
    final angle = _rng.nextDouble() * 2 * pi;
    _direction = Vector2(cos(angle), sin(angle));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (current == NpcState.death) return;

    _stateTimer += dt;
    if (_stateTimer >= _stateDuration) {
      _stateTimer = 0;

      if (_direction.length2 == 0) {
        _pickNewDirection();
      } else {
        _direction = Vector2.zero();
      }
    }

    position += _direction * config.speed * dt;
    _updateAnimationState();
  }

  void _updateAnimationState() {
    if (_direction.length2 == 0) {
      _changeState(NpcState.idle);
    } else {
      _changeState(NpcState.walk);

      if (_direction.x < 0 && !isFlippedHorizontally) {
        flipHorizontallyAroundCenter();
      } else if (_direction.x > 0 && isFlippedHorizontally) {
        flipHorizontallyAroundCenter();
      }
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is WallBlock && current != NpcState.death) {
      _direction = -_direction;
      position += _direction * 2;
      _pickNewDirection();
    }
  }

  void die() {
    _changeState(NpcState.death);
    _direction = Vector2.zero();
  }
}
