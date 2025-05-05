import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              bigCircle: SvgPicture.asset(
                'assets/big_circle.svg',
                width: 25,
                height: 25,
                color: Color(0xFFE5D0E3),
              ),
              avgCircle: SvgPicture.asset(
                'assets/avg_circle.svg',
                width: 18.8,
                height: 18.8,
                color: Color(0xFFE5D0E3),
              ),
              smallCircle: SvgPicture.asset(
                'assets/small_circle.svg',
                width: 14.13,
                height: 14.13,
                color: Color(0xFFE5D0E3),
              ),
              centerIcon: SvgPicture.asset(
                'assets/center_symbol.svg',
                width: 75,
                height: 150,
                color: Color(0xFFE5D0E3),
              )
            ),
            back: Card(
              color: Color(0xFFFBFBFF),
              child: SizedBox(
                height: 430,
                width: 300,
                child: Center(
                  child: Text(
                    widget.number?.toString() ?? "00",
                    style: TextStyle(fontSize: 215, fontWeight: FontWeight.w400, color: Color(0xFF373E40)),
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
