import 'package:educational_system/Post/link_viewer.dart';
import 'package:educational_system/Post/video_player.dart';
import 'package:flutter/material.dart';
import 'image_viewer.dart';

class PostAttachments extends StatelessWidget {
  final List<dynamic> attachments;

  const PostAttachments({Key? key, required this.attachments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: attachments.map((attach) {
          Widget content;
          switch (attach['type']) {
            case 1:
              content = ImageViewer(imageUrl: attach['metadata']['url']);
              break;
            case 2:
              content = VideoPlayerWidget(
                videoUrl: attach['metadata']['url'],
              );
              break;
            case 3:
              content = LinkViewer(
                url: attach['metadata']['url'],
              );
              break;
            default:
              content = LinkViewer(
                url: attach['metadata']['url'],
              );
          }

          return Container(
            //margin: EdgeInsets.only(top: 2),
            child: content,
          );
        }).toList(),
      ),
    );
  }
}
