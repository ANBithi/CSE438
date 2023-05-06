import 'package:educational_system/Post/Reactions/reaction_trigger.dart';
import 'package:flutter/material.dart';
import 'package:educational_system/Comment/comment_contents.dart';
import 'package:educational_system/Helpers/read_data.dart';
import 'package:intl/intl.dart';
import '../Comment/comment_action.dart';
import '../Helpers/util.dart';
import '../Services/post_service.dart';
import 'Reactions/reaction_menu.dart';
import 'Reactions/total_reaction_view.dart';
import 'attachment_viewer.dart';

class PostView extends StatefulWidget {
  const PostView({
    super.key,
    required this.post,
  });
  final post;
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late final date;
  var currentUser = {};
  var comments = [];
  var userReaction;
  var _reactions = [];
  bool _dataLoaded = false;
  bool isHovering = false;
  bool showComments = false;

  @override
  void initState() {
    super.initState();
    date = DateTime.parse(widget.post["createdAt"]);
    _getCredentials();
    fetchComments();
    fetchReactions();
    setState(() {
      _dataLoaded = true;
    });
  }

  void setIsHovering(bool value) {
    setState(() {
      isHovering = value;
    });
  }

  Future<void> _getCredentials() async {
    currentUser = await readUserStorageData();
    setState(() {});
  }

  Future<void> fetchReactions() async {
    getAllReactions(widget.post['id']).then((value) => {
          setState(() {
            userReaction = value.firstWhere(
                (reaction) => reaction['createdById'] == currentUser['id'],
                orElse: () => null);
          }),
          setState(() {
            _reactions = value;
          }),
        });
  }

  void onCommentButtonPressed() {
    setState(() {
      showComments = !showComments;
    });
  }

  Future<void> fetchComments() async {
    getAllComments(widget.post["id"]).then((value) => {
          if (value != null)
            {
              setState(() {
                comments = value;
              }),
            }
        });
  }

  void onReactionClicked(dynamic id, dynamic parentId) {
    var reaction = {"parentId": parentId, "iconId": id};
    addReaction(reaction).then((d) {
      if (d == true) {
        setState(() {
          userReaction = {"iconId": id};
          isHovering = false;
        });
        fetchReactions();
      } else {
        print("failed");
      }
    });
  }

  String get dateFormatted => DateFormat('yyyy-MM-dd').format(date);

  String get timeFormatted => DateFormat('HH:mm:ss').format(date);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _dataLoaded == true
          ? Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(
                    color: currentUser["fullName"] == widget.post["creatorName"]
                        ? colorScheme.tertiaryContainer
                        : colorScheme.secondaryContainer,
                    width: 1.0),
              ),
              color: Colors.white,
              //surfaceTintColor: Colors,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              child: Text(
                                getInitials(widget.post["creatorName"]),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post["creatorName"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Posted on $dateFormatted at $timeFormatted',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          widget.post["postDescription"],
                          style: TextStyle(fontSize: 14),
                        ),
                        PostAttachments(
                            attachments: widget.post["attachments"]),
                        SizedBox(height: 16),
                        if (_reactions.isNotEmpty)
                          TotalReactionView(reactions: _reactions),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Reactions(
                              callback: setIsHovering,
                              reactionsTrigger: ReactionsTrigger(
                                userReaction: userReaction,
                              ),
                            ),
                            CommentAction(
                              length: comments.length,
                              handleEvent: onCommentButtonPressed,
                              post: widget.post["id"],
                              label: "Comment",
                            ),
                          ],
                        ),
                        CommentContents(
                          isVisible: showComments,
                          comments: comments,
                          currentUser: currentUser,
                          parentId: widget.post["id"],
                          fetchComments: fetchComments,
                        )
                      ],
                    ),
                  ),
                  if (isHovering)
                    ReactionViewBox(
                        parentId: widget.post["id"],
                        userReaction: userReaction,
                        onReactionClicked: onReactionClicked),
                ],
              ),
            )
          : LinearLoader(),
    );
  }
}
