import 'package:flutter/material.dart';

class TutorialDialog extends StatefulWidget {
  const TutorialDialog({super.key});

  @override
  State<TutorialDialog> createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog> {
  int _currentStep = 0;

  final List<_TutorialStep> steps = const [
    _TutorialStep(
      title: 'Welcome to',
      description: 'A cooperative ranking game',
      imagePath: 'assets/ordera_logo.png'
    ),
    _TutorialStep(
      title: 'Number of players',
      description: "You can play with 2 players, but it's highly recommended to play with 3-10 players\n(or more if you want a challange)",
    ),
    _TutorialStep(
      title: 'How to play',
      description: """The idea of the game is to correctly rank the number each player drafted (in order) based on what the players said that relates to the theme. So let's try it!
      \n 1. Select a topic to discuss. You can use the top right button list (just draw a number and see what theme it refers to) or create your own topic. Let's use "Best superpower" for the example.
      \n 2. After selecting the topic, set what 1 and 100 means. In our case 1 should be "worse" and 100 "best" superpower.
      """
    ),
    _TutorialStep(
      title: 'How to play',
      description: """\n 3. Then each player should draw a number and keep it a secret from the others. Let's say we got "90".
      \n 4. Now think something to say that would met the scale in which your number is. We could say "invisibility". It's a neat superpower but there are still better ones.
      \n 5. Set where in the table would be your scale (which side is 1 and which is 100).
      """
    ),
    _TutorialStep(
      title: 'How to play',
      description: """6. The first person to say put's the phone with the back of the card facing up in the table. You can write your answer in the text box. In our case, 'invisibility'.
      \n 7. Then the next person have to say something (no order here, the one that already thinked of something). If they think their number is lower than what "invisibility" means, they should think of a worse power, say it and put the phone to the lower side. For example a "60" could be "super strength".
      """,
      imagePath: 'assets/tutorial_placing_cards.png'
    ),
    _TutorialStep(
      title: 'How to play',
      description: """8. Then the next players should do the same. You are free to rediscuss the positions anytime in the game. When you meet a consensus, just reveal the numbers and see if the numbers are in ascending order. (there could be repeated numbers. As long as they are side by side it's a win)
      \nHave Fun !!!
      """,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    final step = steps[_currentStep];

    return AlertDialog(
      title: Text(step.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (step.imagePath != null) ...[
            Image.asset(
              step.imagePath!,
              width: 300,
              height: 150,
            ),
            const SizedBox(height: 12),
          ],
          Text(
            step.description,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        if (_currentStep > 0)
          TextButton(
            onPressed: () => setState(() => _currentStep--),
            child: const Text('Back'),
          ),
        TextButton(
          onPressed: () {
            if (_currentStep < steps.length - 1) {
              setState(() => _currentStep++);
            } else {
              Navigator.pop(context);
            }
          },
          child: Text(
            _currentStep == steps.length -1 ? 'Done' : 'Next',
          )
        ),
      ],
    );
  }
}

class _TutorialStep {
  final String title;
  final String description;
  final String? imagePath;

  const _TutorialStep({
    required this.title,
    required this.description,
    this.imagePath,
  });
}