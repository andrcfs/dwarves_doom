import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../components/wall.dart';
import '../game.dart';

class TiledMapComponent extends Component with HasGameReference<MyGame> {
  late TiledComponent mapComponent;
  late Vector2 mapSize;
  final List<Vector2> walkablePositions = [];

  @override
  Future<void> onLoad() async {
    mapComponent = await TiledComponent.load('map.tmx', Vector2.all(16));
    final tileMap = mapComponent.tileMap;
    mapSize = Vector2(
      (tileMap.map.width * tileMap.map.tileWidth).toDouble(),
      (tileMap.map.height * tileMap.map.tileHeight).toDouble(),
    );
    add(mapComponent);

    // Parse walls and create collision blocks
    final wallsLayer = tileMap.getLayer<TileLayer>('Walls');
    final floorLayer = tileMap.getLayer<TileLayer>('Floor');
    final tileW = tileMap.map.tileWidth.toDouble() / 2; // scaled
    final tileH = tileMap.map.tileHeight.toDouble() / 2; // scaled

    if (wallsLayer != null) {
      for (int y = 0; y < tileMap.map.height; y++) {
        for (int x = 0; x < tileMap.map.width; x++) {
          final gid = wallsLayer.tileData![y][x].tile;
          if (gid != 0) {
            add(
              WallBlock(
                position: Vector2(x * tileW, y * tileH),
                size: Vector2(tileW, tileH),
              ),
            );
          } else if (floorLayer != null &&
              floorLayer.tileData![y][x].tile != 0) {
            walkablePositions.add(
              Vector2(x * tileW + tileW / 2, y * tileH + tileH / 2),
            );
          }
        }
      }
    }

    game.camera.viewfinder.position = Vector2(mapSize.x / 4, mapSize.y / 4);
    print(
      "Map size: $mapSize, tile size: ${tileMap.map.tileWidth}x${tileMap.map.tileHeight}",
    );
    print("Walkable tiles: ${walkablePositions.length}");
  }
}
