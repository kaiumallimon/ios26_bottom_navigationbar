import 'package:flutter/material.dart';
import '../theme/ios26_nav_theme_data.dart';
import 'ios26_ambient_fade.dart';

/// A turnkey Scaffold specifically tuned for floating iOS 26 navigation bars.
///
/// Automatically creates a [Stack] layout where:
/// 1. [body] content flows smoothly underneath the floating bar.
/// 2. An optional [IOS26AmbientFade] gradient is positioned at the bottom to soften underlying content.
/// 3. The floating [navigationBar] is positioned above the bottom safe area inset.
class IOS26NavScaffold extends StatelessWidget {
  /// The primary content widget displayed in the scaffold body.
  final Widget body;

  /// The bottom navigation bar widget (typically [IOS26BottomNavigationBar]).
  final Widget navigationBar;

  /// An optional app bar.
  final PreferredSizeWidget? appBar;

  /// Optional floating action button.
  final Widget? floatingActionButton;

  /// Location of the floating action button.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Optional drawer widget.
  final Widget? drawer;

  /// Optional end drawer widget.
  final Widget? endDrawer;

  /// Background color of the scaffold.
  final Color? backgroundColor;

  /// Whether the body should resize when the on-screen keyboard appears.
  final bool? resizeToAvoidBottomInset;

  /// Whether to extend the body behind the app bar.
  final bool extendBodyBehindAppBar;

  /// Whether to show the ambient bottom fade gradient.
  /// If null, determined by [IOS26NavThemeData.enableAmbientFade].
  final bool? enableAmbientFade;

  /// Custom ambient fade widget. If provided, overrides standard [IOS26AmbientFade].
  final Widget? customAmbientFade;

  /// Custom bottom offset for the navigation bar when no safe area padding exists.
  final double? bottomOffset;

  /// Custom bottom offset added on top of safe area padding.
  final double? safeAreaBottomOffset;

  /// Style configuration override for resolving ambient fade and offsets.
  final IOS26NavThemeData? style;

  const IOS26NavScaffold({
    super.key,
    required this.body,
    required this.navigationBar,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBodyBehindAppBar = false,
    this.enableAmbientFade,
    this.customAmbientFade,
    this.bottomOffset,
    this.safeAreaBottomOffset,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = IOS26NavThemeData.resolve(context, override: style);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    final shouldShowAmbientFade = enableAmbientFade ?? effectiveTheme.enableAmbientFade;
    final effectiveBottomOffset = bottomOffset ?? effectiveTheme.bottomOffset;
    final effectiveSafeAreaOffset = safeAreaBottomOffset ?? effectiveTheme.safeAreaBottomOffset;

    final navBottom = bottomInset > 0
        ? bottomInset + effectiveSafeAreaOffset
        : effectiveBottomOffset;

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: true,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Full Screen Content (passes completely underneath the floating pill)
          Positioned.fill(
            child: body,
          ),

          // 2. Soft Ambient Bottom Fade Gradient
          if (shouldShowAmbientFade)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: customAmbientFade ??
                  IOS26AmbientFade(
                    style: effectiveTheme,
                  ),
            ),

          // 3. Pure Floating iOS 26 Glass Pill Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: navBottom,
            child: navigationBar,
          ),
        ],
      ),
    );
  }
}
