import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../game.dart';

class TiledMapComponent extends Component with HasGameReference<MyGame> {
  late TiledComponent mapComponent;
  late Vector2 mapSize;

  @override
  Future<void> onLoad() async {
    mapComponent = await TiledComponent.load('map.tmx', Vector2.all(16));
    final tileMap = mapComponent.tileMap;
    mapSize = Vector2(
      (tileMap.map.width * tileMap.map.tileWidth).toDouble(),
      (tileMap.map.height * tileMap.map.tileHeight).toDouble(),
    );
    add(mapComponent);
    game.camera.viewfinder.position = Vector2(mapSize.x / 4, mapSize.y / 4);
    print(
      "Map size: $mapSize, tile size: ${tileMap.map.tileWidth}x${tileMap.map.tileHeight}",
    );
    print("viewfinder position: ${game.camera.viewfinder.position}");
  }
}
