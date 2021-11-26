import 'package:flutter/material.dart';

class RotaionIcon extends StatelessWidget {
  final bool rotate;
  final IconData? icon;
  const RotaionIcon({required this.rotate, this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedRotation(
      turns: rotate ? 0.5 : 1,
      duration: const Duration(milliseconds: 200),
      child: Icon(
        icon ?? Icons.keyboard_arrow_up,
        size: 28,
      ));
}
