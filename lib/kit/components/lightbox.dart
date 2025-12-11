import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Fullscreen image viewer with pinch-zoom and navigation.
Future<void> showUkLightbox(
  BuildContext context, {
  required List<ImageProvider> images,
  int initialIndex = 0,
  String? title,
}) async {
  if (images.isEmpty) {
    debugPrint('showUkLightbox called with empty images list');
    return;
  }

  final controller = PageController(initialPage: initialIndex.clamp(0, images.length - 1));
  int index = controller.initialPage;
  final cs = Theme.of(context).colorScheme;

  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withValues(alpha: 0.8),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, a1, a2) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                // Pages
                Positioned.fill(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: images.length,
                    onPageChanged: (i) => setState(() => index = i),
                    itemBuilder: (context, i) {
                      return InteractiveViewer(
                        minScale: 0.8,
                        maxScale: 4.0,
                        child: Center(
                          child: Image(
                            image: images[i],
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Top bar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title ?? 'Lightbox',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: const Icon(Icons.close, color: Colors.white),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                  ),
                ),
                // Left/Right controls
                if (images.length > 1)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        final prev = (index - 1) % images.length;
                        controller.animateToPage(prev < 0 ? images.length - 1 : prev, duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic);
                      },
                      icon: const Icon(Icons.chevron_left, size: 36, color: Colors.white),
                    ),
                  ),
                if (images.length > 1)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        final next = (index + 1) % images.length;
                        controller.animateToPage(next, duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic);
                      },
                      icon: const Icon(Icons.chevron_right, size: 36, color: Colors.white),
                    ),
                  ),
                // Dots
                if (images.length > 1)
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < images.length; i++)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOutCubic,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: i == index ? 22 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: i == index ? cs.primary : Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      );
    },
  );
}
