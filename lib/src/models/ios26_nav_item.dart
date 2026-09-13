import 'package:flutter/widgets.dart';

/// Defines an item in the [IOS26BottomNavigationBar].
///
/// Supports either an [IconData] or custom [Widget] for both normal and active states,
/// optional text or custom widget labels, badges (dot, count, or custom badge widget),
/// per-item color overrides, and per-item selected border overrides.
class IOS26NavItem {
  /// The icon to display when unselected. Can be an [IconData] or custom [Widget].
  final Widget? icon;

  /// The icon data shorthand if using standard font icons (e.g. [Icons.home] or Lucide).
  final IconData? iconData;

  /// The icon to display when selected. If null, falls back to [icon] or [iconData].
  final Widget? activeIcon;

  /// The icon data shorthand when selected. If null, falls back to [iconData].
  final IconData? activeIconData;

  /// The text label displayed below the icon.
  final String? label;

  /// A custom widget to display instead of a standard text label.
  final Widget? customLabel;

  /// Active color override for this specific item.
  /// If null, uses the theme's `activeColor`.
  final Color? activeColor;

  /// Inactive color override for this specific item.
  /// If null, uses the theme's `inactiveColor`.
  final Color? inactiveColor;

  /// Optional border override for the gliding indicator capsule when this item is selected.
  final BoxBorder? selectedBorder;

  /// Optional border color for the gliding indicator capsule when this item is selected.
  final Color? selectedBorderColor;

  /// Optional border width / strength for the gliding indicator capsule when this item is selected.
  final double? selectedBorderWidth;

  /// An optional badge widget to display on top-right of the item icon.
  /// If provided, overrides [badgeCount] and [badgeText].
  final Widget? badge;

  /// Numeric badge count (e.g. 3, 99). If > 0, renders a badge bubble.
  final int? badgeCount;

  /// Text badge (e.g. "NEW", "99+"). If non-empty, renders a badge bubble.
  final String? badgeText;

  /// Whether to show a simple dot badge when neither [badgeCount] nor [badgeText] is set.
  final bool showBadge;

  /// Background color of the badge.
  final Color? badgeColor;

  /// Text color of the badge label.
  final Color? badgeTextColor;

  /// Optional tooltip text when long-pressed or hovered.
  final String? tooltip;

  /// Optional callback invoked when this item is tapped.
  /// This is called in addition to the navigation bar's main `onTap`.
  final VoidCallback? onTap;

  /// Optional arbitrary data or route identifier associated with this item.
  final Object? tag;

  /// Creates an [IOS26NavItem] with maximum customizability.
  const IOS26NavItem({
    this.icon,
    this.iconData,
    this.activeIcon,
    this.activeIconData,
    this.label,
    this.customLabel,
    this.activeColor,
    this.inactiveColor,
    this.selectedBorder,
    this.selectedBorderColor,
    this.selectedBorderWidth,
    this.badge,
    this.badgeCount,
    this.badgeText,
    this.showBadge = false,
    this.badgeColor,
    this.badgeTextColor,
    this.tooltip,
    this.onTap,
    this.tag,
  }) : assert(
          icon != null || iconData != null,
          'Either icon or iconData must be provided for IOS26NavItem.',
        );

  /// Convenience constructor for standard [IconData] items.
  const IOS26NavItem.icon({
    required IconData icon,
    IconData? activeIcon,
    String? label,
    Widget? customLabel,
    Color? activeColor,
    Color? inactiveColor,
    BoxBorder? selectedBorder,
    Color? selectedBorderColor,
    double? selectedBorderWidth,
    Widget? badge,
    int? badgeCount,
    String? badgeText,
    bool showBadge = false,
    Color? badgeColor,
    Color? badgeTextColor,
    String? tooltip,
    VoidCallback? onTap,
    Object? tag,
  }) : this(
          iconData: icon,
          activeIconData: activeIcon,
          label: label,
          customLabel: customLabel,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          selectedBorder: selectedBorder,
          selectedBorderColor: selectedBorderColor,
          selectedBorderWidth: selectedBorderWidth,
          badge: badge,
          badgeCount: badgeCount,
          badgeText: badgeText,
          showBadge: showBadge,
          badgeColor: badgeColor,
          badgeTextColor: badgeTextColor,
          tooltip: tooltip,
          onTap: onTap,
          tag: tag,
        );

  /// Convenience constructor for custom widget items (e.g. SVGs, images, animations).
  const IOS26NavItem.custom({
    required Widget icon,
    Widget? activeIcon,
    String? label,
    Widget? customLabel,
    Color? activeColor,
    Color? inactiveColor,
    BoxBorder? selectedBorder,
    Color? selectedBorderColor,
    double? selectedBorderWidth,
    Widget? badge,
    int? badgeCount,
    String? badgeText,
    bool showBadge = false,
    Color? badgeColor,
    Color? badgeTextColor,
    String? tooltip,
    VoidCallback? onTap,
    Object? tag,
  }) : this(
          icon: icon,
          activeIcon: activeIcon,
          label: label,
          customLabel: customLabel,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          selectedBorder: selectedBorder,
          selectedBorderColor: selectedBorderColor,
          selectedBorderWidth: selectedBorderWidth,
          badge: badge,
          badgeCount: badgeCount,
          badgeText: badgeText,
          showBadge: showBadge,
          badgeColor: badgeColor,
          badgeTextColor: badgeTextColor,
          tooltip: tooltip,
          onTap: onTap,
          tag: tag,
        );
}
