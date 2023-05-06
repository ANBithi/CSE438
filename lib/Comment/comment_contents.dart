import 'package:flutter/material.dart';
import 'comment_box.dart';
import 'comment_list.dart';

class CommentContents extends StatelessWidget {
  final bool isVisible;
  final List<dynamic> comments;
  final dynamic currentUser;
  final String parentId;
  final fetchComments;

  const CommentContents({
    Key? key,
    required this.isVisible,
    required this.comments,
    required this.currentUser,
    required this.parentId,
    required this.fetchComments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (comments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: CommentsList(
                comments: comments,
                currentUser: currentUser,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: CommentBox(
              fetchComments: fetchComments,
              currentUser: currentUser,
              postId: parentId,
            ),
          ),
        ],
      ),
    );
  }
}
