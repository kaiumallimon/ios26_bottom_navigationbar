import 'package:flutter/widgets.dart';
import 'ios26_nav_theme_data.dart';

/// An inherited widget that defines the visual properties for
/// descendant [IOS26BottomNavigationBar] widgets.
class IOS26NavTheme extends InheritedTheme {
  /// The configuration of this theme.
  final IOS26NavThemeData data;

  const IOS26NavTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Retrieves the nearest [IOS26NavThemeData] ancestor, or null if none is found.
  static IOS26NavThemeData? maybeOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<IOS26NavTheme>();
    return theme?.data;
  }

  /// Retrieves the nearest [IOS26NavThemeData] ancestor, or resolves from
  /// standard [IOS26NavThemeData.resolve].
  static IOS26NavThemeData of(BuildContext context) {
    return maybeOf(context) ?? IOS26NavThemeData.resolve(context);
  }

  @override
  bool updateShouldNotify(IOS26NavTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return IOS26NavTheme(data: data, child: child);
  }
}
