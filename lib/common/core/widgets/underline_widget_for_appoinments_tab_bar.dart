
import 'package:flutter/material.dart';

class TabBarIndicatorWidget extends Decoration {
  final BoxPainter _painter;

  TabBarIndicatorWidget({required Color color, required double radius})
      : _painter = _TabBarIndicatorWidget(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _TabBarIndicatorWidget extends BoxPainter {
  final Paint _paint;
  final double radius;

  _TabBarIndicatorWidget(Color color, this.radius)
      : _paint = Paint()
    ..color = color
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration){
    final Offset customOffset = offset +
        Offset(configuration.size!.width / 2,
            configuration.size!.height);

    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromCenter(
              center: customOffset,
              width: configuration.size!.width,
              height: 6),
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
        _paint);
  }
}