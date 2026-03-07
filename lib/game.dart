import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'game_scene.dart';

class MyGame extends FlameGame with HasCollisionDetection {
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.zoom = 2.0;
    //camera.viewfinder.anchor = Anchor.topLeft;
    //camera.viewfinder.position = Vector2.zero();

    router = RouterComponent(
      initialRoute: 'menu',
      routes: {
        'menu': Route(() => Component()),
        'game': Route(() => GameScene()),
      },
    );
    world.add(router);
  }

  void startGame() {
    overlays.remove('menu');
    overlays.add('hud');
    router.pushReplacementNamed('game');
  }

  void returnToMenu() {
    overlays.remove('hud');
    overlays.add('menu');
    router.pushReplacementNamed('menu');
  }

  void restartGame() {
    overlays.remove('hud');
    overlays.add('hud');
    router.pushReplacementNamed('game');
  }
}
