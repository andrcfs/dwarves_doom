import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'npc_config.dart';
import 'wall.dart';

enum NpcState { idle, walk, death }

class Npc extends SpriteAnimationGroupComponent<NpcState>
    with CollisionCallbacks, HasGameReference {
  static final Random _rng = Random();

  final NpcConfig config; // Store the configuration
  Vector2 _direction = Vector2.zero();

  // Require the config in the constructor
  Npc({required Vector2 position, required this.config})
    : super(
        position: position,
        size: config.size, // Use config size
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    // Load dynamically from config paths
    final idleImage = await game.images.load(config.idleSpritePath);
    final walkImage = await game.images.load(config.walkSpritePath);
    final deathImage = await game.images.load(config.deathSpritePath);

    SpriteAnimation createAnimation(dynamic image, int frames) {
      return SpriteAnimation.fromFrameData(
        image,
        SpriteAnimationData.sequenced(
          amount: frames,
          stepTime: config.stepTime, // Use config step time
          textureSize: config.size, // Use config texture size
        ),
      );
    }

    animations = {
      NpcState.idle: createAnimation(idleImage, config.idleFrames),
      NpcState.walk: createAnimation(walkImage, config.walkFrames),
      NpcState.death: createAnimation(deathImage, config.deathFrames),
    };

    current = NpcState.idle;

    // Use config hitbox radius
    add(CircleHitbox(radius: config.hitboxRadius));
    _pickNewDirection();
  }

  void _pickNewDirection() {
    final angle = _rng.nextDouble() * 2 * pi;
    _direction = Vector2(cos(angle), sin(angle));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (current == NpcState.death) return;

    // Use config speed
    position += _direction * config.speed * dt;
    _updateAnimationState();
  }

  void _updateAnimationState() {
    if (_direction.length2 == 0) {
      current = NpcState.idle;
    } else {
      //current = NpcState.walk;

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
    current = NpcState.death;
    _direction = Vector2.zero();
  }
}
