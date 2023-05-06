import 'package:educational_system/Post/post_view.dart';
import 'package:flutter/material.dart';

class PostViewList extends StatelessWidget {
  const PostViewList({
    super.key,
    required this.allPost,
  });

  final List allPost;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: allPost.length,
      itemBuilder: (context, index) {
        var post = allPost[index];
        return PostView(post: post);
      },
    );
  }
}
