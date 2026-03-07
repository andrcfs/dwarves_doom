import 'package:flame/components.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame {
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    router = RouterComponent(
      initialRoute: 'menu',
      routes: {
        'menu': Route(() => Component()),
        'game': Route(() => GameScene()),
      },
    );
    add(router);
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
