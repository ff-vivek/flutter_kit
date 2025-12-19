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
      floatingActionButton: const UkToTopFab(),
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

          // Filter Grid & Iconnav Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: StatefulBuilder(builder: (context, setState) {
                String filter = 'all';
                final items = [
                  UkFilterItem(
                    tags: const {'ui'},
                    child: _filterTile(context, Icons.palette_outlined, 'Design', 'ui'),
                  ),
                  UkFilterItem(
                    tags: const {'data'},
                    child: _filterTile(context, Icons.storage_outlined, 'Datasets', 'data'),
                  ),
                  UkFilterItem(
                    tags: const {'media'},
                    child: _filterTile(context, Icons.photo_library_outlined, 'Gallery', 'media'),
                  ),
                  UkFilterItem(
                    tags: const {'ui', 'data'},
                    child: _filterTile(context, Icons.table_chart_outlined, 'Tables', 'ui,data'),
                  ),
                  UkFilterItem(
                    tags: const {'ui', 'media'},
                    child: _filterTile(context, Icons.slideshow_outlined, 'Carousel', 'ui,media'),
                  ),
                  UkFilterItem(
                    tags: const {'data'},
                    child: _filterTile(context, Icons.query_stats_outlined, 'Analytics', 'data'),
                  ),
                ];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UkHeading('Filter Grid & Iconnav', level: 2),
                    const SizedBox(height: 12),
                    UkCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UkSubnav(
                            items: const ['All', 'UI', 'Data', 'Media'],
                            selectedIndex: const ['all', 'ui', 'data', 'media'].indexOf(filter),
                            onChanged: (i) => setState(() => filter = ['all', 'ui', 'data', 'media'][i]),
                            variant: UkSubnavVariant.underline,
                          ),
                          const SizedBox(height: 12),
                          UkFilterGrid(items: items, activeTag: filter),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    UkCard(
                      header: Text('Iconnav', style: Theme.of(context).textTheme.titleMedium),
                      child: StatefulBuilder(builder: (context, setInner) {
                        int sel = 0;
                        return Row(
                          children: [
                            UkIconnav(
                              items: const [
                                UkIconnavItem(Icons.home_outlined, tooltip: 'Home'),
                                UkIconnavItem(Icons.search_outlined, tooltip: 'Search'),
                                UkIconnavItem(Icons.notifications_none, tooltip: 'Alerts'),
                                UkIconnavItem(Icons.settings_outlined, tooltip: 'Settings'),
                              ],
                              selectedIndex: sel,
                              onChanged: (i) => setInner(() => sel = i),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text('Selected index: $sel', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
          ),

          // Parallax Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Parallax', level: 2),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 180,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          UkParallax(
                            speed: 0.25,
                            child: Image.asset(
                              'assets/images/Futuristic_gradient_waves_blue_1765293466180.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.0),
                                  Colors.black.withValues(alpha: 0.2),
                                ],
                              ),
                            ),
                            child: Text(
                              'Smooth parallax as you scroll',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Navbar & Subnav Showcase
          UkSection(
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Navbar & Subnav', level: 2),
                  const SizedBox(height: 12),
                  UkCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        UkNavbar(
                          title: 'FlutterKit',
                          items: const [
                            UkNavbarItem('Overview', icon: Icons.dashboard_outlined),
                            UkNavbarItem('Components', icon: Icons.widgets_outlined),
                            UkNavbarItem('Docs', icon: Icons.menu_book_outlined),
                          ],
                          actions: const [
                            UkButton(label: 'Sign in', variant: UkButtonVariant.tonal),
                          ],
                        ),
                        const SizedBox(height: 12),
                        StatefulBuilder(builder: (context, setState) {
                          int subIndex = 0;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UkSubnav(
                                items: const ['All', 'UI', 'Data', 'Navigation', 'Overlays'],
                                selectedIndex: subIndex,
                                onChanged: (i) => setState(() => subIndex = i),
                                variant: UkSubnavVariant.underline,
                              ),
                              const SizedBox(height: 8),
                              UkSubnav(
                                items: const ['Popular', 'Latest', 'Trending'],
                                selectedIndex: subIndex % 3,
                                onChanged: (i) => setState(() => subIndex = i),
                                variant: UkSubnavVariant.pills,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Dropbar Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Dropbar', level: 2),
                  const SizedBox(height: 12),
                  UkCard(
                    child: Row(
                      children: [
                        UkButton(
                          label: 'Products',
                          variant: UkButtonVariant.text,
                          onPressed: () {
                            showUkDropbar(
                              context,
                              title: 'Browse products',
                              child: Builder(builder: (context) {
                                final cs = Theme.of(context).colorScheme;
                                return Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    _dropTile(context, Icons.phone_iphone, 'Mobile', 'SDKs, examples', cs),
                                    _dropTile(context, Icons.web, 'Web', 'Widgets, charts', cs),
                                    _dropTile(context, Icons.storage_outlined, 'Data', 'Storage, streams', cs),
                                    _dropTile(context, Icons.security_outlined, 'Security', 'Auth, rules', cs),
                                  ],
                                );
                              }),
                            );
                          },
                        ),
                        UkButton(
                          label: 'Solutions',
                          variant: UkButtonVariant.text,
                          onPressed: () {
                            showUkDropbar(
                              context,
                              title: 'By industry',
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  _dropTile(context, Icons.shopping_bag_outlined, 'E‑commerce', 'Catalogs, checkout', Theme.of(context).colorScheme),
                                  _dropTile(context, Icons.health_and_safety_outlined, 'Health', 'Records, analytics', Theme.of(context).colorScheme),
                                  _dropTile(context, Icons.school_outlined, 'Education', 'Courses, progress', Theme.of(context).colorScheme),
                                ],
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        const UkButton(label: 'Contact sales', variant: UkButtonVariant.outline),
                      ],
                    ),
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

          // Alerts Showcase
          UkSection(
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Alerts', level: 2),
                  const SizedBox(height: 12),
                  const UkAlert(
                    message: 'Heads up! This is an informational alert.',
                    type: UkAlertType.info,
                  ),
                  const SizedBox(height: 8),
                  const UkAlert(
                    message: 'Success! Your changes have been saved.',
                    type: UkAlertType.success,
                  ),
                  const SizedBox(height: 8),
                  const UkAlert(
                    message: 'Warning! Please double-check your input.',
                    type: UkAlertType.warning,
                  ),
                  const SizedBox(height: 8),
                  const UkAlert(
                    message: 'Error! Something went wrong. Try again later.',
                    type: UkAlertType.danger,
                  ),
                ],
              ),
            ),
          ),

          // Breadcrumbs Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Breadcrumb', level: 2),
                  const SizedBox(height: 12),
                  UkBreadcrumb(
                    items: [
                      UkBreadcrumbItem('Home', icon: Icons.home_outlined, onTap: () {}),
                      const UkBreadcrumbItem('Library'),
                      const UkBreadcrumbItem('Components'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Accordion Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Accordion', level: 2),
                  const SizedBox(height: 12),
                  UkAccordion(
                    allowMultiple: false,
                    items: [
                      UkAccordionItem(
                        title: 'What is FlutterKit?',
                        initiallyExpanded: true,
                        content: Text(
                          'A modular, responsive Flutter UI library inspired by UIkit. Built with clean architecture and reusable widgets.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: Icon(Icons.widgets_outlined, color: Theme.of(context).colorScheme.primary),
                      ),
                      UkAccordionItem(
                        title: 'Is it responsive?',
                        content: Text(
                          'Yes. The grid system adapts from 1 to 12 columns across breakpoints.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: Icon(Icons.view_quilt_outlined, color: Theme.of(context).colorScheme.primary),
                      ),
                      UkAccordionItem(
                        title: 'How do I customize it?',
                        content: Text(
                          'Tweak colors and typography in theme.dart. Components use ColorScheme and TextTheme.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: Icon(Icons.tune_outlined, color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tabs Showcase
          UkSection(
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Tabs', level: 2),
                  const SizedBox(height: 12),
                  UkTabs(
                    tabs: const ['Overview', 'Details', 'Settings'],
                    children: [
                      Text('Overview content', style: Theme.of(context).textTheme.bodyMedium),
                      Text('Detailed information appears here.', style: Theme.of(context).textTheme.bodyMedium),
                      Text('Settings panel content.', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Modal Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Modal Sheet', level: 2),
                  const SizedBox(height: 12),
                  UkButton(
                    label: 'Open Modal',
                    icon: Icons.expand_less,
                    onPressed: () {
                      showUkModalSheet(
                        context,
                        title: 'Quick Actions',
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle_outline, color: Theme.of(context).colorScheme.primary),
                                const SizedBox(width: 8),
                                Expanded(child: Text('Confirm changes', style: Theme.of(context).textTheme.bodyMedium)),
                                UkButton(label: 'Apply', size: UkButtonSize.small, onPressed: () => context.pop()),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                                const SizedBox(width: 8),
                                Expanded(child: Text('Delete item', style: Theme.of(context).textTheme.bodyMedium)),
                                UkButton(label: 'Remove', variant: UkButtonVariant.outline, size: UkButtonSize.small, onPressed: () => context.pop()),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Lists Showcase
          UkSection(
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Lists', level: 2),
                  const SizedBox(height: 12),
                  UkCard(
                    child: UkList(
                      variant: UkListVariant.divided,
                      items: const [
                        UkListItemData(
                          'Design tokens',
                          subtitle: 'Colors, typography, and spacing',
                          leading: Icon(Icons.palette_outlined),
                          trailing: Icon(Icons.chevron_right),
                        ),
                        UkListItemData(
                          'Components',
                          subtitle: 'Buttons, cards, lists, tables',
                          leading: Icon(Icons.widgets_outlined),
                          trailing: Icon(Icons.chevron_right),
                        ),
                        UkListItemData(
                          'Patterns',
                          subtitle: 'Navigation, feedback, data display',
                          leading: Icon(Icons.category_outlined),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  UkCard(
                    header: Text('Striped, condensed', style: Theme.of(context).textTheme.titleMedium),
                    child: UkList(
                      variant: UkListVariant.striped,
                      items: const [
                        UkListItemData('Item A', subtitle: 'Details'),
                        UkListItemData('Item B', subtitle: 'More details'),
                        UkListItemData('Item C', subtitle: 'Even more details'),
                        UkListItemData('Item D', subtitle: 'Last entry'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tables Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Tables', level: 2),
                  const SizedBox(height: 12),
                  UkCard(
                    child: UkTable(
                      columns: const ['Name', 'Role', 'Status'],
                      rows: const [
                        ['Alex Lee', 'Designer', 'Active'],
                        ['Taylor Kim', 'Engineer', 'Invited'],
                        ['Sam Morgan', 'PM', 'Active'],
                        ['Jordan Casey', 'Engineer', 'Suspended'],
                      ],
                      striped: true,
                      hover: true,
                      dense: false,
                      bordered: false,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Forms Showcase
          UkSection(
            child: UkContainer(
              child: const _FormsDemo(),
            ),
          ),

          // Skeleton & Upload Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Skeleton & Upload', level: 2),
                  const SizedBox(height: 12),
                  UkCard(
                    header: Text('Skeleton placeholders', style: Theme.of(context).textTheme.titleMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        UkSkeleton(width: 220, height: 18),
                        SizedBox(height: 8),
                        UkSkeleton(width: 320, height: 14),
                        SizedBox(height: 8),
                        UkSkeleton(width: 280, height: 14),
                        SizedBox(height: 12),
                        UkSkeleton(width: 120, height: 12),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  UkCard(
                    header: Text('Upload (picker)', style: Theme.of(context).textTheme.titleMedium),
                    child: StatefulBuilder(builder: (context, setState) {
                      List<String> names = const [];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UkUpload(
                            allowMultiple: true,
                            hint: 'PNG, JPG, PDF up to ~10MB each',
                            onFilesSelected: (files) {
                              setState(() => names = files.map((f) => f.name).toList());
                              if (files.isNotEmpty) {
                                UkToast.show(context, message: 'Selected ${files.length} file(s)', type: UkToastType.info);
                              }
                            },
                          ),
                          if (names.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text('Chosen: ${names.join(', ')}', style: Theme.of(context).textTheme.bodySmall),
                          ]
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Progress & Spinner Showcase
          UkSection(
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Progress & Spinner', level: 2),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Linear (determinate 45%)'),
                      SizedBox(height: 8),
                      UkProgress(value: 0.45),
                      SizedBox(height: 12),
                      Text('Linear (indeterminate)'),
                      SizedBox(height: 8),
                      UkProgress(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: const [
                      UkSpinner(size: UkSpinnerSize.small),
                      UkSpinner(size: UkSpinnerSize.medium, variant: UkSpinnerVariant.secondary),
                      UkSpinner(size: UkSpinnerSize.large, variant: UkSpinnerVariant.success),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tooltip Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Builder(builder: (context) {
                final cs = Theme.of(context).colorScheme;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UkHeading('Tooltip', level: 2),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      children: [
                        UkTooltip(
                          message: 'Edit',
                          child: Icon(Icons.edit_outlined, color: cs.primary),
                        ),
                        UkTooltip(
                          message: 'Share',
                          placement: UkTooltipPlacement.bottom,
                          child: Icon(Icons.ios_share_outlined, color: cs.primary),
                        ),
                        UkTooltip(
                          message: 'Delete',
                          child: Icon(Icons.delete_outline, color: cs.error),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),

          // Countdown Showcase
          UkSection(
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Countdown', level: 2),
                  const SizedBox(height: 12),
                  UkCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sale ends in:', style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(height: 8),
                        UkCountdown(
                          target: DateTime.now().add(const Duration(minutes: 1, seconds: 25)),
                          onComplete: () => UkToast.show(context, message: 'Countdown finished', type: UkToastType.success),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Nav (vertical) Showcase
          UkSection(
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Nav (vertical)', level: 2),
                  const SizedBox(height: 12),
                  UkCard(
                    child: StatefulBuilder(builder: (context, setState) {
                      int selected = 0;
                      return Row(
                        children: [
                          SizedBox(
                            width: 240,
                            child: UkNav(
                              items: const [
                                UkNavItem('Dashboard', icon: Icons.dashboard_outlined, badge: '3'),
                                UkNavItem('Projects', icon: Icons.work_outline),
                                UkNavItem('Teams', icon: Icons.group_outlined),
                                UkNavItem('Settings', icon: Icons.settings_outlined),
                              ],
                              selectedIndex: selected,
                              onChanged: (i) => setState(() => selected = i),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Selected: '
                              '• Dashboard • Projects • Teams • Settings'.split(' • ')[selected],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Switcher Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: StatefulBuilder(builder: (context, setState) {
                int idx = 0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UkHeading('Switcher', level: 2),
                    const SizedBox(height: 12),
                    UkSubnav(
                      items: const ['Overview', 'Reports', 'Activity'],
                      selectedIndex: idx,
                      onChanged: (i) => setState(() => idx = i),
                      variant: UkSubnavVariant.underline,
                    ),
                    const SizedBox(height: 12),
                    UkCard(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UkSwitcher(
                          index: idx,
                          transition: UkSwitcherTransition.slideX,
                          children: [
                            Text('Overview content – summary and highlights', style: Theme.of(context).textTheme.bodyMedium),
                            Text('Reports content – charts and exports', style: Theme.of(context).textTheme.bodyMedium),
                            Text('Activity content – recent events and logs', style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),

          // Dotnav Showcase
          UkSection(
            child: UkContainer(
              child: StatefulBuilder(builder: (context, setState) {
                final controller = PageController();
                int current = 0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UkHeading('Dotnav', level: 2),
                    const SizedBox(height: 12),
                    UkCard(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 120,
                            child: PageView(
                              controller: controller,
                              onPageChanged: (i) => setState(() => current = i),
                              children: [
                                _DotPage(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15), label: 'One'),
                                _DotPage(color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15), label: 'Two'),
                                _DotPage(color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.15), label: 'Three'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          UkDotnav(
                            length: 3,
                            currentIndex: current,
                            onChanged: (i) {
                              setState(() => current = i);
                              controller.animateToPage(i, duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic);
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )
                  ],
                );
              }),
            ),
          ),

          // Overlay Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Overlay', level: 2),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (final img in const [
                        'assets/images/Futuristic_gradient_waves_blue_1765293466180.jpg',
                        'assets/images/Minimalist_desk_setup_white_1765293467212.jpg',
                        'assets/images/City_skyline_at_night_black_1765293468241.jpg',
                      ])
                        SizedBox(
                          width: 180,
                          height: 120,
                          child: UkOverlay(
                            child: Image.asset(img, fit: BoxFit.cover),
                            overlay: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Preview', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: const [
                                      UkButton(label: 'View', size: UkButtonSize.small),
                                      SizedBox(width: 8),
                                      UkButton(label: 'Share', size: UkButtonSize.small, variant: UkButtonVariant.outline),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Dropdown, Toast & Pagination Showcase
          UkSection(
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Dropdown, Toast & Pagination', level: 2),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Builder(builder: (context) {
                        return UkDropdown(
                          trigger: const UkButton(label: 'Actions', variant: UkButtonVariant.outline),
                          items: [
                            UkDropdownItem(
                              'Edit',
                              icon: Icons.edit_outlined,
                              shortcut: 'E',
                              onSelected: () => UkToast.show(context, message: 'Edit clicked', type: UkToastType.info),
                            ),
                            UkDropdownItem(
                              'Share',
                              icon: Icons.ios_share_outlined,
                              shortcut: 'S',
                              onSelected: () => UkToast.show(context, message: 'Share clicked', type: UkToastType.success),
                            ),
                            UkDropdownItem(
                              'Delete',
                              icon: Icons.delete_outline,
                              destructive: true,
                              onSelected: () => UkToast.show(context, message: 'Deleted', type: UkToastType.danger),
                            ),
                          ],
                        );
                      }),
                      UkButton(
                        label: 'Show Info',
                        variant: UkButtonVariant.tonal,
                        onPressed: () => UkToast.show(context, message: 'Information toast', type: UkToastType.info),
                      ),
                      UkButton(
                        label: 'Show Success',
                        onPressed: () => UkToast.show(context, message: 'Saved successfully', type: UkToastType.success),
                      ),
                      UkButton(
                        label: 'Show Warning',
                        variant: UkButtonVariant.outline,
                        onPressed: () => UkToast.show(context, message: 'Be careful with this change', type: UkToastType.warning),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Lightweight local state for the pagination demo
                  Builder(builder: (context) {
                    int current = 3; // initial
                    const total = 10;
                    return StatefulBuilder(builder: (context, setState) {
                      return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Page $current of $total', style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 8),
                        UkPagination(
                          currentPage: current,
                          totalPages: total,
                          onPageChanged: (p) => setState(() {
                            current = p;
                          }),
                        ),
                      ],
                      );
                    });
                  }),
                ],
              ),
            ),
          ),

          // Offcanvas Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Offcanvas', level: 2),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: [
                      UkButton(
                        label: 'Open Left Panel',
                        icon: Icons.menu_open,
                        onPressed: () {
                          showUkOffcanvas(
                            context,
                            title: 'Quick Menu',
                            side: UkOffcanvasSide.left,
                            child: UkList(
                              items: const [
                                UkListItemData('Dashboard', leading: Icon(Icons.dashboard_outlined)),
                                UkListItemData('Components', leading: Icon(Icons.widgets_outlined)),
                                UkListItemData('Settings', leading: Icon(Icons.settings_outlined)),
                              ],
                              variant: UkListVariant.divided,
                            ),
                          );
                        },
                      ),
                      UkButton(
                        label: 'Open Right Panel',
                        variant: UkButtonVariant.outline,
                        icon: Icons.chevron_right,
                        onPressed: () {
                          showUkOffcanvas(
                            context,
                            title: 'Filters',
                            side: UkOffcanvasSide.right,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Choose categories', style: Theme.of(context).textTheme.titleSmall),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: const [
                                    UkBadge('UI'),
                                    UkBadge('Data', variant: UkBadgeVariant.secondary),
                                    UkBadge('Navigation', variant: UkBadgeVariant.tertiary),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Media: Carousel & Lightbox Showcase
          UkSection(
            child: UkContainer(
              child: Builder(builder: (context) {
                final images = const [
                  'assets/images/Futuristic_gradient_waves_blue_1765293466180.jpg',
                  'assets/images/Minimalist_desk_setup_white_1765293467212.jpg',
                  'assets/images/City_skyline_at_night_black_1765293468241.jpg',
                ];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UkHeading('Carousel & Lightbox', level: 2),
                    const SizedBox(height: 12),
                    Builder(builder: (context) {
                      final controller = PageController();
                      int current = 0;
                      return StatefulBuilder(builder: (context, setState) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 200,
                            child: UkSlidenav(
                              onPrevious: () {
                                final i = (current - 1).clamp(0, images.length - 1);
                                setState(() => current = i);
                                controller.animateToPage(i, duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic);
                              },
                              onNext: () {
                                final i = (current + 1).clamp(0, images.length - 1);
                                setState(() => current = i);
                                controller.animateToPage(i, duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic);
                              },
                              child: PageView(
                                controller: controller,
                                onPageChanged: (i) => setState(() => current = i),
                                children: images
                                    .map(
                                      (p) => Image.asset(p, fit: BoxFit.cover),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        );
                      });
                    }),
                    const SizedBox(height: 16),
                    // Thumbnav demo using a custom PageView controller
                    Builder(builder: (context) {
                      final controller = PageController();
                      int current = 0;
                      return StatefulBuilder(builder: (context, setState) {
                        return UkCard(
                          header: Text('Thumbnav', style: Theme.of(context).textTheme.titleMedium),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 140,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: PageView(
                                    controller: controller,
                                    onPageChanged: (i) => setState(() => current = i),
                                    children: images
                                        .map((p) => Image.asset(p, fit: BoxFit.cover))
                                        .toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              UkThumbnav(
                                images: images.map((p) => AssetImage(p) as ImageProvider).toList(),
                                selectedIndex: current,
                                onChanged: (i) {
                                  setState(() => current = i);
                                  controller.animateToPage(i, duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                    }),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for (var i = 0; i < images.length; i++)
                          InkWell(
                            onTap: () => showUkLightbox(
                              context,
                              images: images.map((p) => AssetImage(p)).toList(),
                              initialIndex: i,
                              title: 'Gallery',
                            ),
                            splashFactory: NoSplash.splashFactory,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(images[i], width: 120, height: 80, fit: BoxFit.cover),
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),

          // Search & Sortable Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Search & Sortable', level: 2),
                  const SizedBox(height: 12),
                  UkCard(
                    header: Text('Search (Autocomplete)', style: Theme.of(context).textTheme.titleMedium),
                    child: UkSearchAutocomplete<String>(
                      options: const [
                        'Dashboard', 'Components', 'Lists', 'Tables', 'Navbar', 'Dropdown', 'Lightbox', 'Carousel', 'Upload', 'Skeleton', 'Filter Grid', 'Iconnav',
                      ],
                      displayStringForOption: (s) => s,
                      onSelected: (s) => UkToast.show(context, message: 'Selected "$s"', type: UkToastType.success),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Builder(builder: (context) {
                    var items = <String>['Design tokens', 'Components', 'Patterns', 'Guidelines'];
                    return UkCard(
                      header: Text('Sortable list (drag to reorder)', style: Theme.of(context).textTheme.titleMedium),
                      child: StatefulBuilder(builder: (context, setState) {
                        return UkSortableList<String>(
                          items: items,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemBuilder: (context, item, i) {
                            final cs = Theme.of(context).colorScheme;
                            return Row(
                              children: [
                                Icon(Icons.drag_indicator, color: cs.onSurfaceVariant),
                                const SizedBox(width: 8),
                                Expanded(child: Text(item, style: Theme.of(context).textTheme.bodyMedium)),
                              ],
                            );
                          },
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex -= 1;
                              final item = items.removeAt(oldIndex);
                              items.insert(newIndex, item);
                            });
                          },
                        );
                      }),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Sticky & Scrollspy Showcase
          UkSection(
            variant: UkSectionVariant.muted,
            child: UkContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UkHeading('Sticky & Scrollspy', level: 2),
                  const SizedBox(height: 12),
                  UkCard(
                    header: Text('Sticky header inside a scroll area', style: Theme.of(context).textTheme.titleMedium),
                    child: SizedBox(
                      height: 220,
                      child: CustomScrollView(
                        slivers: [
                          UkSticky(
                            minHeight: 44,
                            maxHeight: 72,
                            builder: (context, shrink, overlaps) {
                              final cs = Theme.of(context).colorScheme;
                              final t = (shrink / (72 - 44)).clamp(0.0, 1.0);
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: cs.surface,
                                  border: Border(
                                    bottom: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.3), width: 1),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(Icons.push_pin_outlined, color: cs.primary),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'I stick to the top while you scroll',
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                    ),
                                    Opacity(
                                      opacity: 1 - 0.4 * t,
                                      child: const UkBadge('Sticky'),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          SliverList.builder(
                            itemCount: 12,
                            itemBuilder: (context, i) {
                              final cs = Theme.of(context).colorScheme;
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.2), width: 1),
                                  ),
                                ),
                                child: Text('Scrollable item #${i + 1}', style: Theme.of(context).textTheme.bodyMedium),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  UkCard(
                    header: Text('Scrollspy reveal', style: Theme.of(context).textTheme.titleMedium),
                    child: UkGrid(
                      children: List.generate(6, (i) {
                        return UkCol(
                          xs: 12,
                          sm: 6,
                          md: 4,
                          child: UkScrollspy(
                            delay: Duration(milliseconds: 60 * i),
                            offset: const Offset(0, 18),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.auto_awesome_outlined, color: Theme.of(context).colorScheme.primary),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Animated tile ${i + 1}',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
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

class _FormsDemo extends StatefulWidget {
  const _FormsDemo();
  @override
  State<_FormsDemo> createState() => _FormsDemoState();
}

class _FormsDemoState extends State<_FormsDemo> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _role;
  bool _news = true;
  String _plan = 'pro';
  bool _notifications = false;
  double _volume = 40;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UkHeading('Forms', level: 2),
        const SizedBox(height: 12),
        UkCard(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UkTextField(
                  controller: _nameController,
                  label: 'Full name',
                  hint: 'Jane Doe',
                  prefixIcon: Icons.person_outline,
                  validator: UkValidators.required(),
                ),
                const SizedBox(height: 12),
                UkTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'jane@example.com',
                  prefixIcon: Icons.alternate_email_outlined,
                  validator: UkValidators.compose([
                    UkValidators.required(),
                    UkValidators.email(),
                  ]),
                ),
                const SizedBox(height: 12),
                const UkTextArea(
                  label: 'About you',
                  hint: 'Short bio…',
                  helperText: '3–6 lines preferred',
                ),
                const SizedBox(height: 12),
                UkSelect<String>(
                  label: 'Role',
                  hint: 'Choose one',
                  value: _role,
                  onChanged: (v) => setState(() => _role = v),
                  options: const [
                    UkOption('Designer', 'designer', icon: Icons.palette_outlined),
                    UkOption('Engineer', 'engineer', icon: Icons.memory_outlined),
                    UkOption('Product Manager', 'pm', icon: Icons.track_changes_outlined),
                  ],
                  validator: (v) => v == null ? 'Please select a role' : null,
                ),
                const SizedBox(height: 16),
                const UkDivider(),
                const SizedBox(height: 8),
                Text('Preferences', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                UkCheckbox(
                  value: _news,
                  onChanged: (v) => setState(() => _news = v ?? false),
                  label: 'Subscribe to newsletter',
                  subtitle: 'Occasional updates — no spam.',
                ),
                const SizedBox(height: 8),
                UkRadio<String>(
                  value: 'free',
                  groupValue: _plan,
                  onChanged: (v) => setState(() => _plan = v ?? 'free'),
                  label: 'Free plan',
                  subtitle: 'Basic features',
                ),
                const SizedBox(height: 4),
                UkRadio<String>(
                  value: 'pro',
                  groupValue: _plan,
                  onChanged: (v) => setState(() => _plan = v ?? 'pro'),
                  label: 'Pro plan',
                  subtitle: 'Everything in Free, plus advanced tools',
                ),
                const SizedBox(height: 8),
                UkSwitch(
                  value: _notifications,
                  onChanged: (v) => setState(() => _notifications = v),
                  label: 'Push notifications',
                  subtitle: 'Get alerts for important activity',
                ),
                const SizedBox(height: 12),
                Text('Volume', style: Theme.of(context).textTheme.labelLarge),
                UkSlider(
                  value: _volume,
                  onChanged: (v) => setState(() => _volume = v),
                  min: 0,
                  max: 100,
                  divisions: 5,
                  label: '${_volume.toStringAsFixed(0)}%',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    UkButton(
                      label: 'Submit',
                      icon: Icons.check_circle_outline,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Saved for ${_nameController.text}'), behavior: SnackBarBehavior.floating),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    UkButton(
                      label: 'Reset',
                      variant: UkButtonVariant.outline,
                      icon: Icons.refresh_outlined,
                      onPressed: () {
                        setState(() {
                          _nameController.clear();
                          _emailController.clear();
                          _role = null;
                          _news = false;
                          _plan = 'free';
                          _notifications = false;
                          _volume = 40;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DotPage extends StatelessWidget {
  const _DotPage({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center,
      child: Text(label, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

Widget _filterTile(BuildContext context, IconData icon, String title, String subtitle) {
  final cs = Theme.of(context).colorScheme;
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: cs.primary),
            const SizedBox(width: 8),
            Expanded(child: Text(title, style: Theme.of(context).textTheme.titleSmall)),
          ],
        ),
        const Spacer(),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
        ),
      ],
    ),
  );
}

Widget _dropTile(BuildContext context, IconData icon, String title, String subtitle, ColorScheme cs) {
  return Container(
    width: 200,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: cs.primary),
            const SizedBox(width: 8),
            Expanded(child: Text(title, style: Theme.of(context).textTheme.titleSmall)),
          ],
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
      ],
    ),
  );
}

