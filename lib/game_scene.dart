import 'package:flame/components.dart';

import 'game.dart';
import 'map/tiled_map.dart';

class GameScene extends Component with HasGameReference<MyGame> {
  @override
  Future<void> onLoad() async {
    final TiledMapComponent tiledMap = TiledMapComponent();
    add(tiledMap);
  }
}
