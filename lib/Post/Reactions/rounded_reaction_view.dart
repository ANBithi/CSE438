import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundedReactionView extends StatelessWidget {
  final reaction;

  RoundedReactionView({required this.reaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.secondaryContainer),
        child: Center(
          child: FaIcon(
            reaction['iconFilled'],
            color: reaction['color'],
            size: 12,
          ),
        ),
      ),
    );
  }
}
