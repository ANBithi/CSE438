import 'package:flutter/material.dart';

import '../Post/Reactions/reaction_list.dart';

int getFileType(String type) {
  switch (type) {
    case 'link':
      return 0;
    case 'photo':
      return 1;
    case 'video':
      return 2;
    case 'pdf':
      return 3;
    default:
      return 4;
  }
}

String getInitials(String name) {
  List<String> names = name.split(" ");
  String initials = "";
  int numWords = 2;
  for (var i = 0; i < names.length && i < numWords; i++) {
    initials += '${names[i][0]}';
  }
  return initials.toUpperCase();
}

class LinearLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 4,
          )
        ],
      ),
    );
  }
}

List<dynamic> findReactionTypes(List<dynamic> allReactions) {
  List<dynamic> foundReactions = [];
  reactionList.forEach((target) {
    List<dynamic> reactions =
        allReactions.where((x) => x['iconId'] == target['id']).toList();
    if (reactions.length == 0) {
      return;
    }
    foundReactions.add(
      {
        "view": target,
        "data": reactions,
        "count": reactions.length,
      },
    );
  });

  foundReactions.sort((firstItem, secondItem) =>
      secondItem["count"].compareTo(firstItem['count']));

  return foundReactions;
}
