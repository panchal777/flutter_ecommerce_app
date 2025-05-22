import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomNetworkWidget extends StatelessWidget {
  final String? imageUrl;

  const CustomNetworkWidget({super.key, this.imageUrl = ''});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl ?? '',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Image loading issue --> $imageUrl ----> ${error.toString()}',);
          return Container(
            color: Colors.grey[300],
            child: Center(child: Icon(Icons.error_outline)),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: Text('Loading'));
        },
      ),
    );
  }
}
