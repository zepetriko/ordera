import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final Function(Color color) onColorTap;

  const ColorSelector({super.key, required this.onColorTap});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Color(0xFFFE4A49),
      Color(0xFF419D78),
      Color(0xFF603140),
      Color(0xFF373E40),
      Color(0xFFF45D01),
      Color(0xFF4BC6B9),
      Color(0xFF857E61),
      Color(0xFFF7C545),
      Color(0xFF3D5A80),
      Color(0xFF4E4C67),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () => onColorTap(color),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        );
      }).toList(),
    );
  }
}
