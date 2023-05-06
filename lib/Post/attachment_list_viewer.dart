import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AttachmentList extends StatelessWidget {
  final List<dynamic> attachments;

  const AttachmentList({Key? key, required this.attachments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var attachment in attachments)
          TextButton(
            child: Text(
              attachment["name"],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: () async {
              var url = attachment["url"];
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
      ],
    );
  }
}
