import 'dart:math';

import 'package:flame/components.dart';

import 'components/npc.dart';
import 'game.dart';
import 'map/tiled_map.dart';

class GameScene extends Component with HasGameReference<MyGame> {
  @override
  Future<void> onLoad() async {
    final TiledMapComponent tiledMap = TiledMapComponent();
    await add(tiledMap);

    // Spawn NPCs at random walkable positions
    final rng = Random();
    final positions = tiledMap.walkablePositions;
    if (positions.isNotEmpty) {
      const npcCount = 8;
      for (int i = 0; i < npcCount; i++) {
        final pos = positions[rng.nextInt(positions.length)];
        add(Npc(position: pos.clone()));
      }
    }
  }
}
