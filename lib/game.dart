import 'package:flame/game.dart';

import 'game_scene.dart';

class MyGame extends FlameGame with HasCollisionDetection {
  GameScene? _gameScene;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.zoom = 2.0;
    overlays.add('menu');
  }

  void startGame() {
    overlays.remove('menu');
    overlays.add('hud');
    _loadGameScene();
  }

  void returnToMenu() {
    overlays.remove('hud');
    overlays.add('menu');
    _clearGameScene();
  }

  void restartGame() {
    _clearGameScene();
    _loadGameScene();
  }

  void _loadGameScene() {
    _gameScene = GameScene();
    world.add(_gameScene!);
  }

  void _clearGameScene() {
    if (_gameScene != null) {
      world.remove(_gameScene!);
      _gameScene = null;
    }
  }
}
