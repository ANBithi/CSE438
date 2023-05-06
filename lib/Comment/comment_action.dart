import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentAction extends StatelessWidget {
  final Function handleEvent;
  final String post;
  final String label;
  final int length;

  const CommentAction(
      {Key? key,
      required this.handleEvent,
      required this.post,
      required this.label,
      required this.length})
      : super(key: key);

  String getText() {
    if (label == "Comment") {
      return length > 1 ? " comments" : " comment";
    } else {
      return length > 1 ? " replies" : " reply";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //behavior: HitTestBehavior.,
      onTap: () => {handleEvent()},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.comments,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4.0),
                Text(
                  "$length",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Text(
                  getText(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
