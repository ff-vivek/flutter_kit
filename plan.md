# UIkit Parity Plan

This project aims to provide a modular, reusable Flutter equivalent of the UIkit component library. All widgets live under `lib/kit/` and are exported via `lib/kit/kit.dart` for easy reuse across apps.

## Status Overview

- Layout: Container, Section, Grid — DONE
- Elements: Heading, Divider, Badge, Progress, Spinner, List, Table, Icon, Skeleton — DONE
- Forms: TextField, TextArea, Select, Checkbox/Radio/Switch, Slider, Upload, Validators — DONE
- Navigation & Menus: Navbar, Subnav, Breadcrumb, Nav (vertical), Dotnav, Iconnav, Switcher — DONE
- Overlays: Dropdown, Modal (bottom sheet), Tooltip, Offcanvas, Lightbox, Overlay, ToTop — DONE
- Media & Interaction: Carousel, Thumbnav, Parallax, Scrollspy, Sticky, Countdown, Filter Grid, Search, Sortable (list) — DONE

## Pending / Next Up

1) Dropbar — Dropdown-style bar under navigation with rich content
2) Slidenav — Large prev/next overlay controls for carousels/hero media
3) Sortable Grid — Drag to reorder grid items (complement to Sortable list)
4) Stepper/Timeline (nice-to-have parity pattern)

## Architecture Notes

- All components are stateless or manage local state only; side-effectful UI is exposed via helper functions (e.g., `showUkOffcanvas`, `showUkLightbox`) to keep call sites simple.
- Theme-first design: components rely on `ColorScheme` and `TextTheme` from `lib/theme.dart`. No hard-coded colors outside theme.
- Navigation: `go_router` (use `context.go`, `context.push`, `context.pop`). No `Navigator.push`.
- Modern Flutter APIs (May 2025): use `withValues(alpha: x)` instead of deprecated `withOpacity`.

## Demo Coverage

`HomePage` showcases each component with accessible, minimal examples so developers can copy-paste usage patterns.

## Roadmap

- Short term: Implement Dropbar and Slidenav with polished demos.
- Medium term: Add Sortable Grid and a compact Stepper/Timeline pattern.
- Long term: Build docs site using these demos as live examples.
