import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image preview'),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.1,
          maxScale: 4,
          boundaryMargin: const EdgeInsets.all(20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Image.network(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                imageUrl,
                fit: BoxFit.contain,
              );
            },
          ),
        ),
      ),
    );
  }
}
