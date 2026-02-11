import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../widgets/flip_card_widget.dart';
import '../widgets/color_selector.dart';
import '../models/settings.dart';
import '../widgets/tutorial_dialog.dart';

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

  Future<List<String>> loadTopics() async {
    final text = await rootBundle.loadString('assets/topics.txt');
    return text
      .split('\n')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
  }

  void _openTopicsMenu() async {
    final topics = await loadTopics();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'Topics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(topics[index])
                    );
                  }
                )
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const TutorialDialog(),
              );
            },
          ),
          centerTitle: true,
          title: Image.asset(
            'assets/ordera_logo.png',
            height: 60,
            fit: BoxFit.contain,
          ),
          toolbarHeight: 100,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: _openTopicsMenu,
            )
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        const SizedBox(height: 12),
                        FlipCardWidget(
                          number: number,
                          backColor: backColor,
                          onGenerate: _onNumberGenerated,  // Callback to update number
                        ),  // Custom widget for flip card
                        const SizedBox(height: 12),
                        ColorSelector(
                          onColorTap: _onColorSelected,  // Callback to update color
                        ),   // Custom widget for color selection
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
