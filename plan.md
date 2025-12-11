# Flutter UIkit Parity Plan

This document tracks UIkit-equivalent components implemented in this Flutter kit and the roadmap ahead.

Status legend: [x] done · [ ] todo · [~] in progress

## Layout
- [x] Container
- [x] Section
- [x] Grid (12-col, responsive)
- [x] Breakpoints utilities

## Elements
- [x] Heading
- [x] Divider
- [x] Badge
- [x] Icon wrapper
- [x] List
- [x] Table
- [x] Progress
- [x] Spinner
- [x] Skeleton (Placeholder)

## Forms
- [x] TextField / TextArea
- [x] Select / Combobox
- [x] Checkbox / Radio / Switch
- [x] Slider (Range)
- [x] Validators helpers
- [x] Upload (picker)
- [ ] Search (compact + autocomplete)

## Components
- [x] Button (variants, sizes)
- [x] Card
- [x] Alert
- [x] Accordion
- [x] Tabs
- [x] Breadcrumb
- [x] Tooltip
- [x] Dropdown / Drop
- [x] Toast / Notification
- [x] Pagination
- [x] Navbar / Subnav
- [x] Nav (vertical)
- [x] Offcanvas
- [x] Modal (modern bottom sheet)
- [x] Overlay (image/content overlay)
- [x] Dotnav
- [x] Switcher
- [x] Lightbox
- [x] Carousel / Slideshow
- [x] Sticky
- [x] Scrollspy
- [x] ToTop
- [x] Countdown
- [x] Parallax
- [x] Iconnav
- [x] Filter Grid
- [ ] Sortable (drag reordering)
- [ ] Thumbnav (slideshow thumbnails)

## Roadmap – Next Up
1) Search (compact search + autocomplete) — current
2) Sortable (reorderable list) — next
3) Thumbnav (thumbnail navigation for media) — next

## Notes
- All components are theme-driven (ColorScheme/TextTheme) and follow modern, minimal styling with rounded corners and subtle states.
- Navigation uses go_router (context.go / context.push / context.pop).
- Backend: none connected. To use Firebase or Supabase, open the corresponding Dreamflow panel and complete setup.
