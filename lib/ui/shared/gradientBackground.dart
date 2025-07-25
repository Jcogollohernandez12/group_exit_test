import 'package:flutter/material.dart';
import 'package:group_exito/core/resources/gen/colors.gen.dart';

class GradientBackground extends StatelessWidget {
  final Widget? child;

  const GradientBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(decoration: const BoxDecoration(color: ColorToken.exitoBlack)),
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(center: Alignment.topRight, focal: Alignment.topRight, radius: 0.8, stops: <double>[0.0, 1.0], colors: <Color>[ColorToken.exitoRed, ColorToken.exitoYellow]),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.bottomLeft,
              radius: 0.75,
              focalRadius: -0.1,
              focal: Alignment.bottomLeft,
              stops: <double>[0.0, 1.0],
              colors: <Color>[ColorToken.exitoBlack, Color(0x00FFFFFF)],
            ),
          ),
        ),
        if (child != null) Padding(padding: const EdgeInsets.all(24), child: child),
      ],
    );
  }
}
