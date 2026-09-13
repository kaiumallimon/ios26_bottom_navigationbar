import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/ios26_nav_item.dart';
import '../theme/ios26_nav_theme.dart';
import '../theme/ios26_nav_theme_data.dart';
import 'ios26_nav_item_widget.dart';

/// An iOS 26 style frosted glass floating bottom navigation bar.
///
/// Features a smooth gliding frosted glass pill indicator capsule,
/// subtle borders, ambient shadows, icon scale animations, and complete
/// customizability over colors, shapes, typography, borders, and badges.
class IOS26BottomNavigationBar extends StatelessWidget {
  /// The list of navigation bar items. Must contain at least 1 item.
  final List<IOS26NavItem> items;

  /// The index of the currently selected item.
  final int currentIndex;

  /// Callback called when an item is tapped with the item's index.
  final ValueChanged<int>? onTap;

  /// Style configuration override for this bar.
  /// If null, resolves from [IOS26NavTheme] or [ThemeData.extensions]
  /// or defaults to light/dark iOS 26 presets.
  final IOS26NavThemeData? style;

  /// Optional direct override for the container border color.
  final Color? borderColor;

  /// Optional direct override for the container border width / strength.
  /// Set to 0.0 to disable the border.
  final double? borderWidth;

  /// Optional direct override for the selected item indicator border color.
  final Color? selectedItemBorderColor;

  /// Optional direct override for the selected item indicator border width / strength.
  /// Set to 0.0 to disable the selected item border.
  final double? selectedItemBorderWidth;

  /// Optional direct override for the selected item indicator border.
  final BoxBorder? selectedItemBorder;

  /// Optional custom builder for the gliding indicator capsule.
  final Widget Function(BuildContext context, int index, Size itemSize)? indicatorBuilder;

  /// Optional custom builder for navigation tab items.
  final Widget Function(
    BuildContext context,
    IOS26NavItem item,
    int index,
    bool isSelected,
    VoidCallback onTap,
  )? itemBuilder;

  const IOS26BottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.style,
    this.borderColor,
    this.borderWidth,
    this.selectedItemBorderColor,
    this.selectedItemBorderWidth,
    this.selectedItemBorder,
    this.indicatorBuilder,
    this.itemBuilder,
  })  : assert(items.length > 0, 'Items list must not be empty.'),
        assert(
          currentIndex >= 0 && currentIndex < items.length,
          'currentIndex ($currentIndex) must be between 0 and items.length - 1 (${items.length - 1}).',
        );

  void _handleTap(int index) {
    if (currentIndex != index) {
      onTap?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = IOS26NavThemeData.resolve(context, override: style);
    final effectiveTheme = (borderColor != null ||
            borderWidth != null ||
            selectedItemBorderColor != null ||
            selectedItemBorderWidth != null ||
            selectedItemBorder != null)
        ? baseTheme.copyWith(
            borderColor: borderColor,
            borderWidth: borderWidth,
            selectedItemBorderColor: selectedItemBorderColor,
            selectedItemBorderWidth: selectedItemBorderWidth,
            selectedItemBorder: selectedItemBorder,
          )
        : baseTheme;

    Widget navBar = Container(
      height: effectiveTheme.height,
      padding: effectiveTheme.padding,
      decoration: BoxDecoration(
        color: effectiveTheme.backgroundGradient == null ? effectiveTheme.backgroundColor : null,
        gradient: effectiveTheme.backgroundGradient,
        borderRadius: effectiveTheme.borderRadius,
        border: effectiveTheme.effectiveBorder,
        boxShadow: effectiveTheme.boxShadow,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          final itemCount = items.length;
          final itemWidth = totalWidth / itemCount;
          final itemSize = Size(itemWidth, constraints.maxHeight);

          final currentItem = items[currentIndex];
          final currentItemBorder = currentItem.selectedBorder ??
              (currentItem.selectedBorderWidth != null && currentItem.selectedBorderColor != null
                  ? Border.all(
                      color: currentItem.selectedBorderColor!,
                      width: currentItem.selectedBorderWidth!,
                    )
                  : effectiveTheme.effectiveIndicatorBorder);

          return Stack(
            children: [
              // Smooth Gliding Frosted Glass Pill Capsule
              AnimatedPositioned(
                duration: effectiveTheme.indicatorAnimationDuration,
                curve: effectiveTheme.indicatorAnimationCurve,
                left: currentIndex * itemWidth,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: Padding(
                  padding: effectiveTheme.indicatorPadding,
                  child: indicatorBuilder?.call(context, currentIndex, itemSize) ??
                      Container(
                        decoration: effectiveTheme.indicatorDecoration ??
                            BoxDecoration(
                              color: effectiveTheme.indicatorColor,
                              borderRadius: effectiveTheme.indicatorBorderRadius,
                              border: currentItemBorder,
                            ),
                      ),
                ),
              ),

              // Navigation Tabs Row
              Row(
                children: List.generate(itemCount, (index) {
                  final item = items[index];
                  final isSelected = index == currentIndex;

                  void handleItemTap() {
                    if (effectiveTheme.enableHapticFeedback) {
                      HapticFeedback.selectionClick();
                    }
                    _handleTap(index);
                  }

                  if (itemBuilder != null) {
                    return Expanded(
                      child: itemBuilder!(
                        context,
                        item,
                        index,
                        isSelected,
                        handleItemTap,
                      ),
                    );
                  }

                  return Expanded(
                    child: IOS26NavItemWidget(
                      item: item,
                      isSelected: isSelected,
                      theme: effectiveTheme,
                      onTap: handleItemTap,
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );

    // Apply backdrop blur if sigma is greater than 0
    if (effectiveTheme.blurSigmaX > 0 || effectiveTheme.blurSigmaY > 0) {
      navBar = ClipRRect(
        borderRadius: effectiveTheme.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: effectiveTheme.blurSigmaX,
            sigmaY: effectiveTheme.blurSigmaY,
          ),
          child: navBar,
        ),
      );
    } else {
      navBar = ClipRRect(
        borderRadius: effectiveTheme.borderRadius,
        child: navBar,
      );
    }

    if (effectiveTheme.margin != EdgeInsets.zero) {
      navBar = Padding(
        padding: effectiveTheme.margin,
        child: navBar,
      );
    }

    return navBar;
  }
}
