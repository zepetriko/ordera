import 'package:flutter/material.dart';
import '../widgets/flip_card_widget.dart';
import '../widgets/color_selector.dart';
import '../models/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color backColor = Colors.blue;
  int? number;

  @override
  void initState() {
    super.initState();
    _loadColor();
  }

  void _loadColor() async {
    Color? saved = await Settings.getColor();
    if (saved != null) {
      setState(() {
        backColor = saved;
      });
    }
  }

   void _onColorSelected(Color color) async {
    await Settings.saveColor(color);
    setState(() {
      backColor = color;
    });
  }

  void _onNumberGenerated(int n) {
    setState(() {
      number = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flip Card App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlipCardWidget(
              number: number,
              backColor: backColor,
              onGenerate: _onNumberGenerated,  // Callback to update number
            ),  // Custom widget for flip card
            const SizedBox(height: 20),
            ColorSelector(
              onColorTap: _onColorSelected,  // Callback to update color
            ),   // Custom widget for color selection
          ],
        ),
      ),
    );
  }
}
