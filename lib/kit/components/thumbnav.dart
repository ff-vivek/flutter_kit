import 'package:flutter/material.dart';

/// A horizontal strip of thumbnails used as navigation for slideshows/galleries.
class UkThumbnav extends StatelessWidget {
  const UkThumbnav({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onChanged,
    this.thumbSize = const Size(72, 48),
    this.spacing = 8,
  });

  final List<ImageProvider> images;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Size thumbSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < images.length; i++) ...[
            _Thumb(
              image: images[i],
              selected: i == selectedIndex,
              size: thumbSize,
              onTap: () => onChanged(i),
            ),
            if (i != images.length - 1) SizedBox(width: spacing),
          ]
        ],
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({
    required this.image,
    required this.selected,
    required this.size,
    required this.onTap,
  });

  final ImageProvider image;
  final bool selected;
  final Size size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      splashFactory: NoSplash.splashFactory,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant.withValues(alpha: 0.4),
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image(image: image, fit: BoxFit.cover),
      ),
    );
  }
}
