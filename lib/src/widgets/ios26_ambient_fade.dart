import 'package:flutter/material.dart';
import '../theme/ios26_nav_theme_data.dart';

/// A soft ambient fade gradient overlay positioned at the bottom of the screen.
///
/// Ensures full screen content smoothly fades out underneath the floating
/// iOS 26 glass pill navigation bar without jarring visual clashes.
class IOS26AmbientFade extends StatelessWidget {
  /// The total height of the gradient overlay.
  /// If null, automatically calculated based on bottom safe area inset.
  final double? height;

  /// Custom gradient colors. If null, uses the colors from [IOS26NavThemeData].
  final List<Color>? colors;

  /// Custom gradient stops. If null, defaults to [0.0, 0.35, 0.75, 1.0].
  final List<double>? stops;

  /// Optional style configuration override.
  final IOS26NavThemeData? style;

  const IOS26AmbientFade({
    super.key,
    this.height,
    this.colors,
    this.stops,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = IOS26NavThemeData.resolve(context, override: style);

    if (!effectiveTheme.enableAmbientFade) {
      return const SizedBox.shrink();
    }

    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final effectiveHeight = height ??
        (bottomInset > 0
            ? bottomInset + 64.0
            : effectiveTheme.ambientFadeHeight);

    final effectiveColors = colors ??
        effectiveTheme.ambientFadeColors ??
        [
          Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.0),
          Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.40),
          Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.85),
          Theme.of(context).scaffoldBackgroundColor,
        ];

    final effectiveStops = stops ?? effectiveTheme.ambientFadeStops;

    return IgnorePointer(
      child: Container(
        height: effectiveHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: effectiveColors,
            stops: effectiveStops,
          ),
        ),
      ),
    );
  }
}
