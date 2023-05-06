import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkViewer extends StatelessWidget {
  final String url;
  final String name;

  const LinkViewer({
    Key? key,
    required this.url,
    this.name = '',
  }) : super(key: key);

  void _launchUrl() async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchUrl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.link),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                name.isNotEmpty ? name : url,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
