import 'package:dwarves_doom/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

final myGame = FlameTester(MyGame.new);

void main() {
  myGame.testGameWidget(
    'game will load its child',
    verify: (game, tester) async {
      game.update(0.0);

      expect(game.children.length, 1);

      await tester.tapAt(const Offset(10, 10));
    },
  );
}
