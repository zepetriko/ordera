import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:math';
import 'dart:async';

import 'package:ordera/widgets/front_flip_card_widget.dart';

class FlipCardWidget extends StatefulWidget {
  final int? number;
  final Color backColor;
  final void Function(int number) onGenerate;

  const FlipCardWidget({
    super.key,
    required this.number,
    required this.backColor,
    required this.onGenerate,
  });

  @override
  _FlipCardWidgetState createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool isFront = true;
  bool isButtonEnabled = true;
  int countdown = 0;

  Timer? _countdownTimer;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      isButtonEnabled = false;
      countdown = 5;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState(() {
        if (countdown > 1) {
          countdown--;
        } else {
          countdown = 0;
          isButtonEnabled = true;
          timer.cancel();
        }
      });
    });
  }


  void _onCardTap(){
    cardKey.currentState?.toggleCard();
    setState(() {
      isFront = !isFront;
    });
  }

  void _drawNumberAndFlip() {
    if (!isButtonEnabled) return;

    _startCountdown();
    
    final randomNumber = Random().nextInt(100) + 1;

    //If card is on front, flip it to back and show number
    if (isFront) {
      setState(() {
          isFront = false;
      });
      cardKey.currentState?.toggleCard();

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          widget.onGenerate(randomNumber);
        }
      });
    } else {
      widget.onGenerate(randomNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _onCardTap,
          child: FlipCard(
            key: cardKey,
            flipOnTouch: false,
            front: CardFrontWidget(
              key: ValueKey(widget.backColor.toString()),
              backgroundColor: widget.backColor,
              cornerSymbol: '♠️',
              centerIcon: Icons.shield,
            ),
            back: Card(
              color: Colors.white10,
              child: SizedBox(
                height: 400,
                width: 300,
                child: Center(
                  child: Text(
                    widget.number?.toString() ?? "No number",
                    style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: isButtonEnabled ? _drawNumberAndFlip : null,
          child: countdown > 0
            ? Text("Wait $countdown...", style: TextStyle(color: Colors.grey),)
            : Text("Draw Number"),
        ),
      ],
    );
  }
}
