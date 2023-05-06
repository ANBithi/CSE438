import 'package:educational_system/Post/Reactions/reactions_modal.dart';
import 'package:educational_system/Post/Reactions/rounded_reaction_view.dart';
import 'package:flutter/material.dart';

import '../../Helpers/util.dart';

class TotalReactionView extends StatefulWidget {
  final List<dynamic> reactions;

  TotalReactionView({
    required this.reactions,
    super.key,
  });

  @override
  _TotalReactionViewState createState() => _TotalReactionViewState();
}

class _TotalReactionViewState extends State<TotalReactionView> {
  List<dynamic> foundReactions = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      foundReactions = findReactionTypes(widget.reactions);
    });
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    foundReactions = findReactionTypes(widget.reactions);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AllReactionsModal(
              reactions: foundReactions,
            );
          },
        ),
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (foundReactions.isNotEmpty)
            Wrap(
              children: [
                for (var i = 0; i < foundReactions.length; i++)
                  Container(
                    margin: EdgeInsets.only(left: i > 0 ? -6.0 : 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    child: RoundedReactionView(
                      reaction: foundReactions[i]['view'],
                    ),
                  ),
                Text('${widget.reactions.length}'),
              ],
            ),
          if (foundReactions.isEmpty) Text('0'),
        ],
      ),
    );
  }
}
