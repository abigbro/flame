import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyGame().widget);

class Ball extends PositionComponent {
  final Size gameSize;
  final paint = Paint()..color = const Color(0xFFFFFFFF);

  bool foward = true;

  Ball(this.gameSize);

  @override
  void render(Canvas c) {
    c.drawOval(toRect(), paint);
  }

  @override
  void update(double delta) {
    x += (foward ? 1 : -1) * 100 * delta;

    if (x <= 0 || x + width >= gameSize.width) {
      if (foward) {
        x = gameSize.width - width - 1;
      } else {
        x = 1;
      }

      foward = !foward;
      print('boin');
      Flame.audio.play('boin.mp3', volume: 1.2);
    }
  }
}

class MyGame extends BaseGame {
  MyGame() {
    _start();
  }

  void _start() async {
    final Size size = await Flame.util.initialDimensions();

    Flame.audio.disableLog();
    Flame.audio.load('boin.mp3');
    Flame.audio.loop('music.mp3', volume: 0.4);

    add(Ball(size)
      ..y = (size.height / 2) - 50
      ..width = 100
      ..height = 100);
  }
}
