import 'package:flutter/material.dart';

import 'custom_network_widget.dart';

class ImageCarouselWithDots extends StatefulWidget {
  final List<String> imageUrls;
  final BoxFit? fit;

  const ImageCarouselWithDots({super.key, required this.imageUrls, this.fit});

  @override
  State<ImageCarouselWithDots> createState() => _ImageCarouselWithDotsState();
}

class _ImageCarouselWithDotsState extends State<ImageCarouselWithDots> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() => _currentPage = page);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.imageUrls.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 8 : 6,
          height: isActive ? 8 : 6,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return CustomNetworkWidget(
                imageUrl: widget.imageUrls[index],
                fit: widget.fit ?? BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        _buildDots(),
        const SizedBox(height: 5),
      ],
    );
  }
}
