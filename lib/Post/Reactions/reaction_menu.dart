import 'package:educational_system/Post/Reactions/reaction_list.dart';
import 'package:flutter/material.dart';

class Reactions extends StatefulWidget {
  final Function(bool) callback;
  final Widget reactionsTrigger;

  const Reactions({
    Key? key,
    required this.callback,
    required this.reactionsTrigger,
  }) : super(key: key);

  @override
  _ReactionsState createState() => _ReactionsState();
}

class _ReactionsState extends State<Reactions> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.callback(true),
      child: Column(
        children: [
          widget.reactionsTrigger,
        ],
      ),
    );
  }
}

class ReactionViewBox extends StatelessWidget {
  const ReactionViewBox({
    super.key,
    required this.parentId,
    required this.userReaction,
    required this.onReactionClicked,
  });

  final String parentId;
  final dynamic userReaction;
  final Function(String, String) onReactionClicked;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50, // adjust as per your requirement
      left: 15,
      child: Container(
        width: 200,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, crossAxisSpacing: 0, childAspectRatio: 1),
          itemCount: reactionList.length,
          itemBuilder: (context, index) {
            final reaction = reactionList[index];
            return Row(
              children: [
                _buildReactionButton(reaction, userReaction == reaction['id'],
                    onReactionClicked),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildReactionButton(
      dynamic iconData, bool isSelected, Function(String, String) onPressed) {
    return IconButton(
      icon: Icon(
        iconData['iconFilled'],
        color: iconData['color'],
        size: 20,
      ),
      onPressed: () => onPressed(iconData['id'], parentId),
    );
  }
}
