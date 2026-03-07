import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class WallBlock extends PositionComponent with CollisionCallbacks {
  WallBlock({required Vector2 position, required Vector2 size})
    : super(position: position, size: size);
  late final RectangleHitbox hitbox;

  @override
  Future<void> onLoad() async {
    //debugColor = const Color(0x88FF0000);
    //debugMode = true;
    hitbox = RectangleHitbox();
    hitbox.isSolid = true;

    add(hitbox);
  }
}
