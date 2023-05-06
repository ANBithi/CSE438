import 'package:educational_system/Post/Reactions/reaction_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReactionsTrigger extends StatelessWidget {
  final userReaction;
  const ReactionsTrigger({Key? key, this.userReaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var found;
    if (userReaction == null) {
      found = null;
    } else {
      found = reactionList.firstWhere((x) => x['id'] == userReaction['iconId']);
    }

    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              (found != null)
                  ? found["icon"] == null
                      ? FontAwesomeIcons.thumbsUp
                      : found['iconFilled']
                  : FontAwesomeIcons.thumbsUp,
              color: found == null ? Colors.grey : found['color']),
          SizedBox(width: 4),
          Text(
            found == null ? 'Like' : found['name'],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: found != null
                    ? found['color'] ?? Colors.grey
                    : Colors.grey),
          ),
        ],
      ),
    );
  }
}
