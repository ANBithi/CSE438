import 'package:flutter/material.dart';

class AttachmentPopover extends StatefulWidget {
  final List<dynamic> attachments;
  final Map<dynamic, dynamic> postObject;
  final dynamic setPostObject;
  const AttachmentPopover({
    Key? key,
    required this.postObject,
    required this.setPostObject,
    required this.attachments,
  }) : super(key: key);

  @override
  _AttachmentPopoverState createState() => _AttachmentPopoverState();
}

class _AttachmentPopoverState extends State<AttachmentPopover> {
  String? _url;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Url with https://'),
          content: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter a URL',
            ),
            onChanged: (value) {
              setState(() {
                _url = value;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_url != null) {
                  widget.attachments
                      .add({'fileFormat': "link", 'url': _url, 'name': _url});
                  var post = {
                    ...widget.postObject,
                    'attachments': widget.attachments
                  };
                  widget.setPostObject(post);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _showDialog,
      icon: Icon(Icons.link),
      label: Text('Link'),
    );
  }
}
