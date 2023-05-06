import 'package:flutter/material.dart';

import 'comment_item.dart';

class CommentsList extends StatelessWidget {
  final dynamic comments;
  final dynamic currentUser;

  const CommentsList({
    Key? key,
    required this.comments,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 4),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: comments.length,
        itemBuilder: (BuildContext context, int index) {
          return CommentItem(
            comment: comments[index],
            currentUser: currentUser,
          );
        },
      ),
    );
  }
}
