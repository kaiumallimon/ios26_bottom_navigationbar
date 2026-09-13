import 'package:flutter/material.dart';
import '../models/ios26_nav_item.dart';
import '../theme/ios26_nav_theme_data.dart';

/// Internal widget rendering an individual tab item within [IOS26BottomNavigationBar].
class IOS26NavItemWidget extends StatelessWidget {
  final IOS26NavItem item;
  final bool isSelected;
  final IOS26NavThemeData theme;
  final VoidCallback onTap;

  const IOS26NavItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = item.activeColor ?? theme.activeColor;
    final inactiveColor = item.inactiveColor ?? theme.inactiveColor;
    final currentColor = isSelected ? activeColor : inactiveColor;

    final shouldShowLabel = theme.showLabels &&
        (isSelected
            ? (theme.showSelectedLabels ?? true)
            : (theme.showUnselectedLabels ?? true)) &&
        (item.label != null || item.customLabel != null);

    final effectiveLabelStyle = (isSelected ? theme.selectedLabelStyle : theme.labelStyle)
        .copyWith(color: currentColor);

    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon with scale animation and optional badge
          AnimatedScale(
            scale: isSelected ? theme.selectedIconScale : 1.0,
            duration: theme.iconScaleAnimationDuration,
            curve: theme.iconScaleAnimationCurve,
            child: _buildIconWithBadge(context, currentColor),
          ),

          // Label
          if (shouldShowLabel) ...[
            SizedBox(height: theme.labelSpacing),
            AnimatedDefaultTextStyle(
              duration: theme.labelAnimationDuration,
              curve: theme.labelAnimationCurve,
              style: effectiveLabelStyle,
              child: item.customLabel ??
                  Text(
                    item.label!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ],
        ],
      ),
    );

    if (item.tooltip != null && item.tooltip!.isNotEmpty) {
      content = Tooltip(
        message: item.tooltip!,
        child: content,
      );
    }

    return GestureDetector(
      onTap: () {
        item.onTap?.call();
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }

  Widget _buildIconWithBadge(BuildContext context, Color currentColor) {
    final iconWidget = _resolveIcon(currentColor);

    final hasCustomBadge = item.badge != null;
    final hasCountBadge = item.badgeCount != null && item.badgeCount! > 0;
    final hasTextBadge = item.badgeText != null && item.badgeText!.isNotEmpty;
    final hasDotBadge = item.showBadge;

    if (!hasCustomBadge && !hasCountBadge && !hasTextBadge && !hasDotBadge) {
      return iconWidget;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconWidget,
        Positioned(
          top: -3,
          right: -6,
          child: _buildBadge(),
        ),
      ],
    );
  }

  Widget _resolveIcon(Color currentColor) {
    if (isSelected) {
      if (item.activeIcon != null) {
        return IconTheme(
          data: IconThemeData(
            size: theme.iconSize,
            color: currentColor,
          ),
          child: item.activeIcon!,
        );
      }
      if (item.activeIconData != null) {
        return Icon(
          item.activeIconData,
          size: theme.iconSize,
          color: currentColor,
        );
      }
    }

    if (item.icon != null) {
      return IconTheme(
        data: IconThemeData(
          size: theme.iconSize,
          color: currentColor,
        ),
        child: item.icon!,
      );
    }

    return Icon(
      item.iconData,
      size: theme.iconSize,
      color: currentColor,
    );
  }

  Widget _buildBadge() {
    if (item.badge != null) {
      return item.badge!;
    }

    final badgeColor = item.badgeColor ?? theme.badgeColor;
    final badgeTextColor = item.badgeTextColor ?? theme.badgeTextColor;

    if (item.badgeCount != null && item.badgeCount! > 0) {
      final text = item.badgeCount! > 99 ? '99+' : item.badgeCount.toString();
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
        decoration: BoxDecoration(
          color: badgeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(
          minWidth: 15,
          minHeight: 15,
        ),
        child: Center(
          child: Text(
            text,
            style: theme.badgeTextStyle ??
                TextStyle(
                  color: badgeTextColor,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
          ),
        ),
      );
    }

    if (item.badgeText != null && item.badgeText!.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
        decoration: BoxDecoration(
          color: badgeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(
          minWidth: 15,
          minHeight: 15,
        ),
        child: Center(
          child: Text(
            item.badgeText!,
            style: theme.badgeTextStyle ??
                TextStyle(
                  color: badgeTextColor,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
          ),
        ),
      );
    }

    // Small dot badge
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
