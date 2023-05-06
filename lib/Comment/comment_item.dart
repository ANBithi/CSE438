import 'package:educational_system/Post/Reactions/reaction_trigger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Helpers/util.dart';
import '../Post/Reactions/reaction_menu.dart';
import '../Services/post_service.dart';
import 'comment_action.dart';
import 'comment_contents.dart';

class CommentItem extends StatefulWidget {
  final dynamic comment;
  final dynamic currentUser;

  CommentItem({required this.comment, required this.currentUser});

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _showReply = false;
  bool _dataLoaded = false;
  bool _isLongPressed = false;
  dynamic _userReaction;
  dynamic _reactions;
  late var date;
  late var userInitials;
  var _comments = [];

  void _onCommentsClick() {
    setState(() {
      _showReply = !_showReply;
    });
  }

  void onReactionLongPressed(bool value) {
    setState(() {
      _isLongPressed = value;
    });
  }

  @override
  void initState() {
    super.initState();
    userInitials = getInitials(widget.comment['createdBy']);
    date = DateTime.parse(widget.comment["createdAt"]);
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchComments();
    await fetchReactions();
    setState(() {
      _dataLoaded = true;
    });
  }

  String get dateFormatted => DateFormat('yyyy-MM-dd').format(date);

  String get timeFormatted => DateFormat('HH:mm:ss').format(date);

  void _onReactionClicked(String id, String parentId) {
    addReaction({'parentId': parentId, 'iconId': id}).then((d) {
      if (d == true) {
        setState(() {
          _userReaction = {'iconId': id};
          _isLongPressed = false;
        });
        fetchReactions();
      } else {}
    });
  }

  Future<void> fetchReactions() async {
    final response = await getAllReactions(widget.comment['id']);
    if (response != null) {
      final userReaction = response.firstWhere(
        (reaction) => reaction['createdById'] == widget.currentUser['id'],
        orElse: () => null,
      );
      setState(() {
        _userReaction = userReaction;
        _reactions = response;
      });
    }
  }

  Future<void> fetchComments() async {
    getAllComments(widget.comment['id']).then((value) => {
          if (value != null)
            {
              setState(() {
                _comments = value;
              }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 8, 4, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  child: Text(
                    userInitials,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_dataLoaded)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                '${widget.comment['createdBy']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, top: 4.0),
                              child: Text(
                                'Commented on $dateFormatted at $timeFormatted',
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, top: 4.0),
                              child: Text(
                                '${widget.comment["content"]}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, top: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Reactions(
                                    reactionsTrigger: ReactionsTrigger(
                                      userReaction: _userReaction,
                                    ),
                                    callback: onReactionLongPressed,
                                  ),
                                  CommentAction(
                                    length: _comments.length,
                                    label: 'Reply',
                                    handleEvent: _onCommentsClick,
                                    post: widget.comment["id"],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, top: 4.0),
                              child: CommentContents(
                                fetchComments: fetchComments,
                                isVisible: _showReply,
                                currentUser: widget.currentUser,
                                parentId: widget.comment["id"],
                                comments: _comments,
                              ),
                            ),
                          ],
                        ),
                      if (!_dataLoaded)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isLongPressed)
            ReactionViewBox(
                parentId: widget.comment["id"],
                userReaction: _userReaction,
                onReactionClicked: _onReactionClicked),
        ],
      ),
    );
  }
}

// class CommentAction extends StatelessWidget {
//   const CommentAction({
//     Key? key,
//     required this.label,
//     required this.onActionTapped,
//     required this.post,
//   }) : super(key: key);

//   final String label;
//   final Function() onActionTapped;
//   final int post;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onActionTapped,
//       child: Row(
//         children: [
//           const SizedBox(width: 8.0),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w600,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CommentContents extends StatelessWidget {
//   const CommentContents({
//     Key? key,
//     required this.comments,
//     required this.currentUser,
//     required this.parentId,
//   }) : super(key: key);

//   final List<Comment> comments;
//   final User currentUser;
//   final int parentId;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (final comment in comments.where((comment) => comment.parentId == parentId))
//           CommentItem(
//             comment: comment,
//             currentUser: currentUser,
//           ),
//       ],
//     );
//   }
// }

// class Reactions extends StatefulWidget {
//   const Reactions({
//     Key? key,
//     required this.reactions,
//     required this.currentUser,
//     required this.userReaction,
//     required this.onReactionClicked,
//   }) : super(key: key);

//   final List<Reaction> reactions;
//   final User currentUser;
//   final Reaction? userReaction;
//   final Function(int id, int parentId) onReactionClicked;

//   @override
//   _ReactionsState createState() => _ReactionsState();
// }

// class _ReactionsState extends State<Reactions> {
//   late List<Reaction>
