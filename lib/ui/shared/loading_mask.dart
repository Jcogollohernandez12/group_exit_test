import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:group_exito/core/resources/foundations/font_foundation.dart';
import 'package:group_exito/core/resources/gen/assets.gen.dart';
import 'package:group_exito/core/resources/gen/colors.gen.dart';

class LoadingMask extends StatefulWidget {
  const LoadingMask({super.key, required this.loading, required this.child});
  final bool loading;
  final Widget child;

  @override
  LoadingMaskState createState() => LoadingMaskState();
}

class LoadingMaskState extends State<LoadingMask> {
  late double angle;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    angle = 0.0;

    if (widget.loading) {
      timer = Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
        _updateAngle();
      });
    }
  }

  void _updateAngle() {
    setState(() {
      angle = sin(DateTime.now().millisecondsSinceEpoch / 50.0) * 0.025;
    });
  }

  @override
  void didUpdateWidget(covariant LoadingMask oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading != oldWidget.loading) {
      if (widget.loading) {
        timer?.cancel();
        timer = Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
          _updateAngle();
        });
      } else {
        timer?.cancel();
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: <Widget>[
      widget.child,
      if (widget.loading) ...<Widget>[
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(color: Colors.black.withOpacity(0.16)),
          ),
        ),
        Positioned(
          right: 0,
          top: MediaQuery.of(context).size.height / 2,
          child: Transform.rotate(origin: const Offset(128, 67), angle: angle, child: Assets.svgs.iconExito.svg()),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2,
          child: Center(
            child: Text('Cargando...', style: FontFoundation.title.bold20Lato.copyWith(color: ColorToken.exitoBlack)),
          ),
        ),
      ],
    ],
  );
}
