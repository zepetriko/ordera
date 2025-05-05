import 'package:flutter/material.dart';

class CardFrontWidget extends StatelessWidget {
  final Color backgroundColor;
  final Widget bigCircle;
  final Widget avgCircle;
  final Widget smallCircle;
  final Widget centerIcon;

  const CardFrontWidget({
    super.key,
    required this.backgroundColor,
    required this.bigCircle,
    required this.centerIcon, 
    required this.avgCircle, 
    required this.smallCircle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(12)
      ),
      elevation: 4,
      child: SizedBox(
        width: 300,
        height: 430,
        child: Stack(
          children: [
            Center(
              child: centerIcon,
            ),

            Positioned(
              top: 15,
              left: 15,
              child: bigCircle,
            ),
            Positioned(
              top: 60,
              left: 18.1,
              child: avgCircle,
            ),
            Positioned(
              top: 105,
              left: 20.435,
              child: smallCircle,
            ),
            
            Positioned(
              bottom: 15,
              right: 15,
              child: Transform.rotate(
                angle: 3.1416,
                child: bigCircle,
                ),
            ),
            Positioned(
              bottom: 60,
              right: 18.1,
              child: Transform.rotate(
                angle: 3.1416,
                child: avgCircle,
                ),
            ),
            Positioned(
              bottom: 105,
              right: 20.435,
              child: Transform.rotate(
                angle: 3.1416,
                child: smallCircle,
                ),
            ),
          ],
        ),
      ),
    );
  }
}