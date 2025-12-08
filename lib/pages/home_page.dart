import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../kit/kit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FlutterKit ⚡️'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Hero Section
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              size: UkContainerSize.large,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Build fast. Look modern.', level: 1),
                  const SizedBox(height: 8),
                  Text(
                    'A modular Flutter component library inspired by UIkit — responsive, elegant, and reusable.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      UkButton(label: 'Explore Components', onPressed: () {}),
                      UkButton(
                        label: 'Get Started',
                        variant: UkButtonVariant.tonal,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Buttons Showcase
          UkSection(
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Buttons', level: 2),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      UkButton(label: 'Primary'),
                      UkButton(label: 'Secondary', variant: UkButtonVariant.secondary),
                      UkButton(label: 'Tonal', variant: UkButtonVariant.tonal),
                      UkButton(label: 'Outline', variant: UkButtonVariant.outline),
                      UkButton(label: 'Text', variant: UkButtonVariant.text),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Grid & Card Showcase
          UkSection(
            variant: UkSectionVariant.normal,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Responsive Grid + Cards', level: 2),
                  const SizedBox(height: 12),
                  UkGrid(
                    children: List.generate(6, (i) {
                      return UkCol(
                        xs: 12,
                        sm: 6,
                        md: 4,
                        child: UkCard(
                          header: Row(
                            children: [
                              UkBadge('Card', variant: UkBadgeVariant.neutral),
                              const SizedBox(width: 8),
                              Text('Item ${i + 1}', style: Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This card sits in a responsive grid. Resize to see it adapt.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  UkButton(
                                    label: 'Action',
                                    size: UkButtonSize.small,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 8),
                                  UkButton(
                                    label: 'Details',
                                    variant: UkButtonVariant.outline,
                                    size: UkButtonSize.small,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Badges & Divider Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Badges & Dividers', level: 2),
                  const SizedBox(height: 12),
                  const UkDivider(),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      UkBadge('Primary'),
                      UkBadge('Secondary', variant: UkBadgeVariant.secondary),
                      UkBadge('Tertiary', variant: UkBadgeVariant.tertiary),
                      UkBadge('Neutral', variant: UkBadgeVariant.neutral),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              UkButton(
                label: 'Home',
                icon: Icons.home_outlined,
                variant: UkButtonVariant.text,
                onPressed: () => context.go('/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
