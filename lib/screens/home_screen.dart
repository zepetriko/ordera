import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
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
    WakelockPlus.enable();
    _loadColor();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SvgPicture.asset(
            'assets/ordera_logo.svg',
            height: 60,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: 0.75,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Text here',
                    hintStyle: TextStyle( color: Colors.grey.shade400),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      )
                    )
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
      ),
    );
  }
}
