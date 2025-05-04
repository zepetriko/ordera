import 'package:flutter/material.dart';

class CardFrontWidget extends StatefulWidget {
  final Color backgroundColor;
  final String cornerSymbol;
  final IconData centerIcon;

  const CardFrontWidget({
    super.key,
    required this.backgroundColor,
    required this.cornerSymbol,
    this.centerIcon = Icons.star,
  });

  @override
  _CardFrontWidgetState createState() => _CardFrontWidgetState();
}

class _CardFrontWidgetState extends State<CardFrontWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(12)
      ),
      elevation: 4,
      child: SizedBox(
        width: 300,
        height: 400,
        child: Stack(
          children: [
            Center(
              child: Icon(
                widget.centerIcon,
                size: 100,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 8,
              left: 12,
              child: Text(
                widget.cornerSymbol,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 12,
              child: Transform.rotate(
                angle: 3.1416,
                child: Text(
                  widget.cornerSymbol,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}