import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';

class LargeTitleDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double maxHeight;
  final Widget? action;

  LargeTitleDelegate({required this.title, required this.maxHeight, this.action});

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);

    final double delta = (maxExtent - minExtent);
    final double t = (shrinkOffset / (delta > 0 ? delta : 1)).clamp(0.0, 1.0);

    // interpolate font size (large -> compact)
    final double fontSize = lerpDouble(34, 20, t)!;
    // move title up as we shrink
    final double translateY = lerpDouble(0, -18, t)!;
    // optional scale (subtle)
    final double scale = lerpDouble(1.0, 0.96, t)!;

    return Container(
      color: theme.canvasColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            children: [
              // Title anchored to bottom-left, but translated up when scrolled
              Align(
                alignment: Alignment.bottomLeft,
                child: Transform.translate(
                  offset: Offset(0, translateY),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: theme.textTheme.headlineLarge?.copyWith(fontSize: fontSize),
                    ),
                  ),
                ),
              ),
              if (action != null)
                Positioned(
                  right: 0,
                  bottom: 8 + translateY, // align vertically with title baseline
                  child: Opacity(opacity: lerpDouble(1.0, 0.95, t)!, child: action),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant LargeTitleDelegate oldDelegate) {
    return oldDelegate.title != title || oldDelegate.maxHeight != maxHeight || oldDelegate.action != action;
  }
}
