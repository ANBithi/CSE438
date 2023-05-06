import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final String imageUrl;

  const ImageViewer({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late ImageProvider _imageProvider;

  @override
  void initState() {
    super.initState();
    _imageProvider = CachedNetworkImageProvider(
      widget.imageUrl,
      headers: {'Access-Control-Allow-Origin': '*'},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 200,
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          imageBuilder: (context, imageProvider) => GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: Image(image: imageProvider),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10),
          //   image: DecorationImage(
          //     image: NetworkImage(widget.imageUrl),
          //     fit: BoxFit.cover,
          //   ),
          // ),
        ));
  }
}
