import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
      children: [
        ...colors.map((color) {
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

        GestureDetector(
          onTap: () => _pickCustomColor(context),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              size: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  void _pickCustomColor(BuildContext context) {
    Color selectedColor = Colors.white;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor, 
              onColorChanged: (color) {
                selectedColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: const Text('Cancel')
            ),
            TextButton(
              onPressed: () {
                onColorTap(selectedColor);
                Navigator.of(context).pop();
              }, 
              child: const Text('Select'),
            ),
          ],
        );
      }
    );
  }

}
