import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FontAwesomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // do something when button is pressed
      },
      icon: Icon(
        FontAwesomeIcons.solidHeart,
        size: 16.0,
      ),
      label: Text('Like'),
    );
  }
}
