import 'package:flutter/material.dart';

import '../Services/post_service.dart';

class CommentBox extends StatefulWidget {
  final currentUser;
  final postId;
  final fetchComments;
  const CommentBox(
      {Key? key,
      required this.currentUser,
      required this.postId,
      required this.fetchComments})
      : super(key: key);

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: TextField(
              controller: _commentController,
              maxLines: 1,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 14),
                hintText: 'Write a comment...',
                border: InputBorder.none,
              ),
            ),
          ),
          ButtonBar(
            children: [
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.done),
                onPressed: () {
                  onCommentClick();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onCommentClick() {
    String commentContent = _commentController.text;
    if (commentContent.isNotEmpty) {
      var postPayload = {
        "content": commentContent,
        "parentId": widget.postId,
      };
      postComment(postPayload).then((response) => {
            if (response == true)
              {
                _commentController.clear(),
                widget.fetchComments(),
              }
            else
              {}
          });
    }
  }
}

// class CommentBox extends StatefulWidget {
//   const CommentBox({Key? key}) : super(key: key);

//   @override
//   _CommentBoxState createState() => _CommentBoxState();
// }

// class _CommentBoxState extends State<CommentBox> {
//   TextEditingController _textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _textEditingController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 hintText: 'Write a comment...',
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           ButtonBar(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.photo_camera),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: () {
//                   String comment = _textEditingController.text;
//                   if (comment.isNotEmpty) {
//                     // do something with the comment
//                     _textEditingController.clear();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
