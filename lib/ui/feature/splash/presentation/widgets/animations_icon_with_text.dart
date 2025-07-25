import 'package:flutter/material.dart';
import 'package:group_exito/core/resources/foundations/font_foundation.dart';
import 'package:group_exito/core/resources/gen/assets.gen.dart';
import 'package:group_exito/core/resources/gen/colors.gen.dart';

class AnimatedIconWithText extends StatefulWidget {
  const AnimatedIconWithText({super.key});

  @override
  State<AnimatedIconWithText> createState() => _AnimatedIconWithTextState();
}

class _AnimatedIconWithTextState extends State<AnimatedIconWithText> with TickerProviderStateMixin {
  late final AnimationController _iconScaleController;
  late final AnimationController _iconSlideTextController;

  late final Animation<double> _iconScaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _iconScaleController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);

    _iconSlideTextController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    _iconScaleAnimation = Tween<double>(begin: 4.0, end: 1.6).animate(CurvedAnimation(parent: _iconScaleController, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _iconSlideTextController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _iconScaleController.forward().whenComplete(() {
      _iconSlideTextController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = FontFoundation.title.bold24Lato.copyWith(color: ColorToken.neutral200);
    final double textHeight = textStyle.fontSize ?? 24;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: _iconScaleController,
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: _iconScaleAnimation.value,
              child: Assets.svgs.iconExito.svg(fit: BoxFit.contain, height: textHeight * 1.2, width: textHeight * 1.2),
            );
          },
        ),
        const SizedBox(height: 12),
        FadeTransition(
          opacity: _fadeAnimation,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'Almacenes',
                  style: FontFoundation.title.bold24Lato.copyWith(color: ColorToken.exitoBlack),
                ),
                TextSpan(
                  text: '  Supermercados',
                  style: FontFoundation.title.regular24Lato.copyWith(color: ColorToken.exitoRed),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
