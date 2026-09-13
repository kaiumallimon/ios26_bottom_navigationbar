import 'dart:ui';
import 'package:flutter/material.dart';

/// Defines the styling and theme parameters for [IOS26BottomNavigationBar]
/// and [IOS26NavScaffold].
///
/// Implements [ThemeExtension] so it can be registered globally in your app's
/// [ThemeData.extensions], passed directly to the navigation bar widget,
/// or provided via [IOS26NavTheme].
@immutable
class IOS26NavThemeData extends ThemeExtension<IOS26NavThemeData> {
  // --- Container Bar Dimensions & Layout ---
  /// Total height of the navigation bar container. Default: 62.0
  final double height;

  /// Internal padding of the navigation bar container. Default: EdgeInsets.all(5.0)
  final EdgeInsetsGeometry padding;

  /// Outer margin surrounding the floating bar. Default: EdgeInsets.symmetric(horizontal: 16.0)
  final EdgeInsetsGeometry margin;

  /// Bottom offset when floating in a scaffold without bottom safe area inset. Default: 16.0
  final double bottomOffset;

  /// Additional bottom offset when safe area padding is present. Default: 4.0
  final double safeAreaBottomOffset;

  // --- Glassmorphism & Surface Decoration ---
  /// Background color of the frosted glass capsule.
  final Color backgroundColor;

  /// Optional background gradient for the navigation bar container.
  final Gradient? backgroundGradient;

  /// Full custom [BoxBorder] of the glass capsule container.
  /// If provided, overrides [borderColor] and [borderWidth].
  final BoxBorder? border;

  /// Color of the capsule border.
  final Color? borderColor;

  /// Width / thickness / strength of the capsule border. Default: 0.9.
  /// Set to 0.0 to disable the border completely.
  final double borderWidth;

  /// Border radius of the bar container. Default: BorderRadius.circular(38.0)
  final BorderRadiusGeometry borderRadius;

  /// Backdrop filter blur sigma along the X-axis. Default: 30.0
  final double blurSigmaX;

  /// Backdrop filter blur sigma along the Y-axis. Default: 30.0
  final double blurSigmaY;

  /// Box shadows applied to the navigation bar container.
  final List<BoxShadow>? boxShadow;

  // --- Gliding Frosted Indicator Capsule ---
  /// Color of the gliding pill indicator.
  final Color indicatorColor;

  /// Optional full decoration for the gliding indicator (overrides [indicatorColor] and [indicatorBorderRadius]).
  final Decoration? indicatorDecoration;

  /// Optional border color for the gliding pill indicator. Default: null (no border).
  final Color? indicatorBorderColor;

  /// Width / strength of the gliding pill indicator border. Default: 0.0.
  final double indicatorBorderWidth;

  /// Border radius of the gliding pill indicator. Default: BorderRadius.circular(30.0)
  final BorderRadiusGeometry indicatorBorderRadius;

  /// Internal padding / insets for the gliding indicator capsule. Default: EdgeInsets.zero
  final EdgeInsetsGeometry indicatorPadding;

  /// Duration for the indicator translation animation. Default: 300ms
  final Duration indicatorAnimationDuration;

  /// Curve for the indicator translation animation. Default: Curves.fastEaseInToSlowEaseOut
  final Curve indicatorAnimationCurve;

  // --- Item Icons & Labels Styling ---
  /// Color applied to the active/selected tab item icon and label.
  final Color activeColor;

  /// Color applied to unselected tab item icons and labels.
  final Color inactiveColor;

  /// Default icon size for tab items. Default: 19.0
  final double iconSize;

  /// Scale factor applied to the icon when selected. Default: 1.08
  final double selectedIconScale;

  /// Animation duration for the icon scale effect. Default: 260ms
  final Duration iconScaleAnimationDuration;

  /// Animation curve for the icon scale effect. Default: Curves.easeOutBack
  final Curve iconScaleAnimationCurve;

  /// Spacing between the icon and the text label. Default: 2.5
  final double labelSpacing;

  /// Text style for unselected item labels.
  final TextStyle labelStyle;

  /// Text style for selected item labels.
  final TextStyle selectedLabelStyle;

  /// Animation duration for label text style transitions. Default: 200ms
  final Duration labelAnimationDuration;

  /// Animation curve for label text style transitions. Default: Curves.easeOut
  final Curve labelAnimationCurve;

  /// Whether labels are displayed. Default: true
  final bool showLabels;

  /// Whether to show labels on selected items. If null, falls back to [showLabels].
  final bool? showSelectedLabels;

  /// Whether to show labels on unselected items. If null, falls back to [showLabels].
  final bool? showUnselectedLabels;

  // --- Badges ---
  /// Default background color for item badge bubbles.
  final Color badgeColor;

  /// Default text color for item badge labels.
  final Color badgeTextColor;

  /// Badge text style override.
  final TextStyle? badgeTextStyle;

  // --- Interaction & Haptics ---
  /// Whether subtle haptic feedback triggers when a tab is tapped. Default: true
  final bool enableHapticFeedback;

  // --- Ambient Bottom Fade Gradient ---
  /// Colors used for the ambient fade gradient behind the floating navbar.
  final List<Color>? ambientFadeColors;

  /// Gradient stops for the ambient fade. Default: [0.0, 0.35, 0.75, 1.0]
  final List<double> ambientFadeStops;

  /// Height of the ambient fade gradient overlay when there is no safe area inset. Default: 76.0
  final double ambientFadeHeight;

  /// Whether the ambient fade gradient is enabled in [IOS26NavScaffold]. Default: true
  final bool enableAmbientFade;

  const IOS26NavThemeData({
    required this.height,
    required this.padding,
    required this.margin,
    required this.bottomOffset,
    required this.safeAreaBottomOffset,
    required this.backgroundColor,
    this.backgroundGradient,
    this.border,
    this.borderColor,
    this.borderWidth = 0.9,
    required this.borderRadius,
    required this.blurSigmaX,
    required this.blurSigmaY,
    this.boxShadow,
    required this.indicatorColor,
    this.indicatorDecoration,
    this.indicatorBorderColor,
    this.indicatorBorderWidth = 0.0,
    required this.indicatorBorderRadius,
    required this.indicatorPadding,
    required this.indicatorAnimationDuration,
    required this.indicatorAnimationCurve,
    required this.activeColor,
    required this.inactiveColor,
    required this.iconSize,
    required this.selectedIconScale,
    required this.iconScaleAnimationDuration,
    required this.iconScaleAnimationCurve,
    required this.labelSpacing,
    required this.labelStyle,
    required this.selectedLabelStyle,
    required this.labelAnimationDuration,
    required this.labelAnimationCurve,
    this.showLabels = true,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    required this.badgeColor,
    required this.badgeTextColor,
    this.badgeTextStyle,
    this.enableHapticFeedback = true,
    this.ambientFadeColors,
    this.ambientFadeStops = const [0.0, 0.35, 0.75, 1.0],
    this.ambientFadeHeight = 76.0,
    this.enableAmbientFade = true,
  });

  /// Resolves the effective [BoxBorder] for the navigation bar container.
  BoxBorder? get effectiveBorder {
    if (border != null) {
      return border;
    }
    if (borderWidth <= 0 || borderColor == null || borderColor == Colors.transparent) {
      return null;
    }
    return Border.all(color: borderColor!, width: borderWidth);
  }

  /// Light mode theme preset matching iOS 26 glass aesthetic.
  factory IOS26NavThemeData.light({
    Color? activeColor,
    Color? inactiveColor,
    Color? backgroundColor,
    Color? indicatorColor,
    Color? indicatorBorderColor,
    double? indicatorBorderWidth,
    Color? badgeColor,
    Color? badgeTextColor,
    TextStyle? labelStyle,
    TextStyle? selectedLabelStyle,
    List<Color>? ambientFadeColors,
    double? height,
    BorderRadiusGeometry? borderRadius,
    Color? borderColor,
    double? borderWidth,
    BoxBorder? border,
  }) {
    final effectiveActiveColor = activeColor ?? const Color(0xFF5B15FC);
    final effectiveInactiveColor = inactiveColor ?? const Color(0xFF6B7280);
    final effectiveBorderColor = borderColor ?? Colors.white.withValues(alpha: 0.85);
    final effectiveBorderWidth = borderWidth ?? 0.9;
    final effectiveBorder = border ??
        (effectiveBorderWidth > 0 && effectiveBorderColor != Colors.transparent
            ? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth)
            : null);

    return IOS26NavThemeData(
      height: height ?? 62.0,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      bottomOffset: 16.0,
      safeAreaBottomOffset: 4.0,
      backgroundColor: backgroundColor ?? const Color(0xFFF6F6F8).withValues(alpha: 0.80),
      border: effectiveBorder,
      borderColor: effectiveBorderColor,
      borderWidth: effectiveBorderWidth,
      borderRadius: borderRadius ?? BorderRadius.circular(38.0),
      blurSigmaX: 30.0,
      blurSigmaY: 30.0,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 28.0,
          offset: const Offset(0, 8),
        ),
      ],
      indicatorColor: indicatorColor ?? Colors.white.withValues(alpha: 0.94),
      indicatorBorderColor: indicatorBorderColor,
      indicatorBorderWidth: indicatorBorderWidth ?? 0.0,
      indicatorBorderRadius: BorderRadius.circular(30.0),
      indicatorPadding: EdgeInsets.zero,
      indicatorAnimationDuration: const Duration(milliseconds: 300),
      indicatorAnimationCurve: Curves.fastEaseInToSlowEaseOut,
      activeColor: effectiveActiveColor,
      inactiveColor: effectiveInactiveColor,
      iconSize: 19.0,
      selectedIconScale: 1.08,
      iconScaleAnimationDuration: const Duration(milliseconds: 260),
      iconScaleAnimationCurve: Curves.easeOutBack,
      labelSpacing: 2.5,
      labelStyle: labelStyle ??
          const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.1,
          ),
      selectedLabelStyle: selectedLabelStyle ??
          const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.1,
          ),
      labelAnimationDuration: const Duration(milliseconds: 200),
      labelAnimationCurve: Curves.easeOut,
      showLabels: true,
      badgeColor: badgeColor ?? const Color(0xFFFF3B30),
      badgeTextColor: badgeTextColor ?? Colors.white,
      enableHapticFeedback: true,
      ambientFadeColors: ambientFadeColors ??
          [
            const Color(0xFFFAF8F5).withValues(alpha: 0.0),
            const Color(0xFFFAF8F5).withValues(alpha: 0.40),
            const Color(0xFFFAF8F5).withValues(alpha: 0.85),
            const Color(0xFFFAF8F5),
          ],
      ambientFadeStops: const [0.0, 0.35, 0.75, 1.0],
      ambientFadeHeight: 76.0,
      enableAmbientFade: true,
    );
  }

  /// Dark mode theme preset matching iOS 26 dark glass aesthetic.
  factory IOS26NavThemeData.dark({
    Color? activeColor,
    Color? inactiveColor,
    Color? backgroundColor,
    Color? indicatorColor,
    Color? indicatorBorderColor,
    double? indicatorBorderWidth,
    Color? badgeColor,
    Color? badgeTextColor,
    TextStyle? labelStyle,
    TextStyle? selectedLabelStyle,
    List<Color>? ambientFadeColors,
    double? height,
    BorderRadiusGeometry? borderRadius,
    Color? borderColor,
    double? borderWidth,
    BoxBorder? border,
  }) {
    final effectiveActiveColor = activeColor ?? const Color(0xFFBF5AF2);
    final effectiveInactiveColor = inactiveColor ?? const Color(0xFF8E8E93);
    final effectiveBorderColor = borderColor ?? Colors.white.withValues(alpha: 0.18);
    final effectiveBorderWidth = borderWidth ?? 0.9;
    final effectiveBorder = border ??
        (effectiveBorderWidth > 0 && effectiveBorderColor != Colors.transparent
            ? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth)
            : null);

    return IOS26NavThemeData(
      height: height ?? 62.0,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      bottomOffset: 16.0,
      safeAreaBottomOffset: 4.0,
      backgroundColor: backgroundColor ?? const Color(0xFF161618).withValues(alpha: 0.72),
      border: effectiveBorder,
      borderColor: effectiveBorderColor,
      borderWidth: effectiveBorderWidth,
      borderRadius: borderRadius ?? BorderRadius.circular(38.0),
      blurSigmaX: 30.0,
      blurSigmaY: 30.0,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.50),
          blurRadius: 28.0,
          offset: const Offset(0, 8),
        ),
      ],
      indicatorColor: indicatorColor ?? Colors.white.withValues(alpha: 0.16),
      indicatorBorderColor: indicatorBorderColor,
      indicatorBorderWidth: indicatorBorderWidth ?? 0.0,
      indicatorBorderRadius: BorderRadius.circular(30.0),
      indicatorPadding: EdgeInsets.zero,
      indicatorAnimationDuration: const Duration(milliseconds: 300),
      indicatorAnimationCurve: Curves.fastEaseInToSlowEaseOut,
      activeColor: effectiveActiveColor,
      inactiveColor: effectiveInactiveColor,
      iconSize: 19.0,
      selectedIconScale: 1.08,
      iconScaleAnimationDuration: const Duration(milliseconds: 260),
      iconScaleAnimationCurve: Curves.easeOutBack,
      labelSpacing: 2.5,
      labelStyle: labelStyle ??
          const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.1,
          ),
      selectedLabelStyle: selectedLabelStyle ??
          const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.1,
          ),
      labelAnimationDuration: const Duration(milliseconds: 200),
      labelAnimationCurve: Curves.easeOut,
      showLabels: true,
      badgeColor: badgeColor ?? const Color(0xFFFF453A),
      badgeTextColor: badgeTextColor ?? Colors.white,
      enableHapticFeedback: true,
      ambientFadeColors: ambientFadeColors ??
          [
            const Color(0xFF000000).withValues(alpha: 0.0),
            const Color(0xFF000000).withValues(alpha: 0.40),
            const Color(0xFF000000).withValues(alpha: 0.85),
            const Color(0xFF000000),
          ],
      ambientFadeStops: const [0.0, 0.35, 0.75, 1.0],
      ambientFadeHeight: 76.0,
      enableAmbientFade: true,
    );
  }

  /// Automatically resolves styling from [BuildContext], checking in order:
  /// 1. An explicit [override] if provided
  /// 2. [Theme.of(context).extension<IOS26NavThemeData>()]
  /// 3. Standard dark or light preset based on [Theme.of(context).brightness]
  /// adapting to [ThemeData.colorScheme.primary] and [ThemeData.scaffoldBackgroundColor].
  static IOS26NavThemeData resolve(
    BuildContext context, {
    IOS26NavThemeData? override,
  }) {
    if (override != null) {
      return override;
    }

    final extensionTheme = Theme.of(context).extension<IOS26NavThemeData>();
    if (extensionTheme != null) {
      return extensionTheme;
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final base = isDark
        ? IOS26NavThemeData.dark(
            activeColor: theme.colorScheme.primary != const Color(0xff6750a4)
                ? theme.colorScheme.primary
                : null,
            ambientFadeColors: [
              theme.scaffoldBackgroundColor.withValues(alpha: 0.0),
              theme.scaffoldBackgroundColor.withValues(alpha: 0.40),
              theme.scaffoldBackgroundColor.withValues(alpha: 0.85),
              theme.scaffoldBackgroundColor,
            ],
          )
        : IOS26NavThemeData.light(
            activeColor: theme.colorScheme.primary != const Color(0xff6750a4)
                ? theme.colorScheme.primary
                : null,
            ambientFadeColors: [
              theme.scaffoldBackgroundColor.withValues(alpha: 0.0),
              theme.scaffoldBackgroundColor.withValues(alpha: 0.40),
              theme.scaffoldBackgroundColor.withValues(alpha: 0.85),
              theme.scaffoldBackgroundColor,
            ],
          );

    return base;
  }

  @override
  IOS26NavThemeData copyWith({
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? bottomOffset,
    double? safeAreaBottomOffset,
    Color? backgroundColor,
    Gradient? backgroundGradient,
    BoxBorder? border,
    Color? borderColor,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    double? blurSigmaX,
    double? blurSigmaY,
    List<BoxShadow>? boxShadow,
    Color? indicatorColor,
    Decoration? indicatorDecoration,
    Color? indicatorBorderColor,
    double? indicatorBorderWidth,
    BorderRadiusGeometry? indicatorBorderRadius,
    EdgeInsetsGeometry? indicatorPadding,
    Duration? indicatorAnimationDuration,
    Curve? indicatorAnimationCurve,
    Color? activeColor,
    Color? inactiveColor,
    double? iconSize,
    double? selectedIconScale,
    Duration? iconScaleAnimationDuration,
    Curve? iconScaleAnimationCurve,
    double? labelSpacing,
    TextStyle? labelStyle,
    TextStyle? selectedLabelStyle,
    Duration? labelAnimationDuration,
    Curve? labelAnimationCurve,
    bool? showLabels,
    bool? showSelectedLabels,
    bool? showUnselectedLabels,
    Color? badgeColor,
    Color? badgeTextColor,
    TextStyle? badgeTextStyle,
    bool? enableHapticFeedback,
    List<Color>? ambientFadeColors,
    List<double>? ambientFadeStops,
    double? ambientFadeHeight,
    bool? enableAmbientFade,
  }) {
    final effectiveBorderColor = borderColor ?? this.borderColor;
    final effectiveBorderWidth = borderWidth ?? this.borderWidth;
    final effectiveBorder = border ??
        ((borderColor != null || borderWidth != null)
            ? (effectiveBorderWidth > 0 && effectiveBorderColor != null && effectiveBorderColor != Colors.transparent
                ? Border.all(color: effectiveBorderColor, width: effectiveBorderWidth)
                : null)
            : this.border);

    return IOS26NavThemeData(
      height: height ?? this.height,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      bottomOffset: bottomOffset ?? this.bottomOffset,
      safeAreaBottomOffset: safeAreaBottomOffset ?? this.safeAreaBottomOffset,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      border: effectiveBorder,
      borderColor: effectiveBorderColor,
      borderWidth: effectiveBorderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      blurSigmaX: blurSigmaX ?? this.blurSigmaX,
      blurSigmaY: blurSigmaY ?? this.blurSigmaY,
      boxShadow: boxShadow ?? this.boxShadow,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      indicatorDecoration: indicatorDecoration ?? this.indicatorDecoration,
      indicatorBorderColor: indicatorBorderColor ?? this.indicatorBorderColor,
      indicatorBorderWidth: indicatorBorderWidth ?? this.indicatorBorderWidth,
      indicatorBorderRadius: indicatorBorderRadius ?? this.indicatorBorderRadius,
      indicatorPadding: indicatorPadding ?? this.indicatorPadding,
      indicatorAnimationDuration: indicatorAnimationDuration ?? this.indicatorAnimationDuration,
      indicatorAnimationCurve: indicatorAnimationCurve ?? this.indicatorAnimationCurve,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      iconSize: iconSize ?? this.iconSize,
      selectedIconScale: selectedIconScale ?? this.selectedIconScale,
      iconScaleAnimationDuration: iconScaleAnimationDuration ?? this.iconScaleAnimationDuration,
      iconScaleAnimationCurve: iconScaleAnimationCurve ?? this.iconScaleAnimationCurve,
      labelSpacing: labelSpacing ?? this.labelSpacing,
      labelStyle: labelStyle ?? this.labelStyle,
      selectedLabelStyle: selectedLabelStyle ?? this.selectedLabelStyle,
      labelAnimationDuration: labelAnimationDuration ?? this.labelAnimationDuration,
      labelAnimationCurve: labelAnimationCurve ?? this.labelAnimationCurve,
      showLabels: showLabels ?? this.showLabels,
      showSelectedLabels: showSelectedLabels ?? this.showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels ?? this.showUnselectedLabels,
      badgeColor: badgeColor ?? this.badgeColor,
      badgeTextColor: badgeTextColor ?? this.badgeTextColor,
      badgeTextStyle: badgeTextStyle ?? this.badgeTextStyle,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      ambientFadeColors: ambientFadeColors ?? this.ambientFadeColors,
      ambientFadeStops: ambientFadeStops ?? this.ambientFadeStops,
      ambientFadeHeight: ambientFadeHeight ?? this.ambientFadeHeight,
      enableAmbientFade: enableAmbientFade ?? this.enableAmbientFade,
    );
  }

  @override
  IOS26NavThemeData lerp(ThemeExtension<IOS26NavThemeData>? other, double t) {
    if (other is! IOS26NavThemeData) {
      return this;
    }

    return IOS26NavThemeData(
      height: lerpDouble(height, other.height, t) ?? height,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t) ?? margin,
      bottomOffset: lerpDouble(bottomOffset, other.bottomOffset, t) ?? bottomOffset,
      safeAreaBottomOffset:
          lerpDouble(safeAreaBottomOffset, other.safeAreaBottomOffset, t) ?? safeAreaBottomOffset,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      backgroundGradient: Gradient.lerp(backgroundGradient, other.backgroundGradient, t),
      border: BoxBorder.lerp(effectiveBorder, other.effectiveBorder, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
      blurSigmaX: lerpDouble(blurSigmaX, other.blurSigmaX, t) ?? blurSigmaX,
      blurSigmaY: lerpDouble(blurSigmaY, other.blurSigmaY, t) ?? blurSigmaY,
      boxShadow: BoxShadow.lerpList(boxShadow, other.boxShadow, t),
      indicatorColor: Color.lerp(indicatorColor, other.indicatorColor, t) ?? indicatorColor,
      indicatorDecoration: Decoration.lerp(indicatorDecoration, other.indicatorDecoration, t),
      indicatorBorderColor: Color.lerp(indicatorBorderColor, other.indicatorBorderColor, t),
      indicatorBorderWidth:
          lerpDouble(indicatorBorderWidth, other.indicatorBorderWidth, t) ?? indicatorBorderWidth,
      indicatorBorderRadius:
          BorderRadiusGeometry.lerp(indicatorBorderRadius, other.indicatorBorderRadius, t) ??
              indicatorBorderRadius,
      indicatorPadding:
          EdgeInsetsGeometry.lerp(indicatorPadding, other.indicatorPadding, t) ?? indicatorPadding,
      indicatorAnimationDuration: other.indicatorAnimationDuration,
      indicatorAnimationCurve: other.indicatorAnimationCurve,
      activeColor: Color.lerp(activeColor, other.activeColor, t) ?? activeColor,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t) ?? inactiveColor,
      iconSize: lerpDouble(iconSize, other.iconSize, t) ?? iconSize,
      selectedIconScale: lerpDouble(selectedIconScale, other.selectedIconScale, t) ?? selectedIconScale,
      iconScaleAnimationDuration: other.iconScaleAnimationDuration,
      iconScaleAnimationCurve: other.iconScaleAnimationCurve,
      labelSpacing: lerpDouble(labelSpacing, other.labelSpacing, t) ?? labelSpacing,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t) ?? labelStyle,
      selectedLabelStyle:
          TextStyle.lerp(selectedLabelStyle, other.selectedLabelStyle, t) ?? selectedLabelStyle,
      labelAnimationDuration: other.labelAnimationDuration,
      labelAnimationCurve: other.labelAnimationCurve,
      showLabels: t < 0.5 ? showLabels : other.showLabels,
      showSelectedLabels: t < 0.5 ? showSelectedLabels : other.showSelectedLabels,
      showUnselectedLabels: t < 0.5 ? showUnselectedLabels : other.showUnselectedLabels,
      badgeColor: Color.lerp(badgeColor, other.badgeColor, t) ?? badgeColor,
      badgeTextColor: Color.lerp(badgeTextColor, other.badgeTextColor, t) ?? badgeTextColor,
      badgeTextStyle: TextStyle.lerp(badgeTextStyle, other.badgeTextStyle, t),
      enableHapticFeedback: t < 0.5 ? enableHapticFeedback : other.enableHapticFeedback,
      ambientFadeColors: other.ambientFadeColors,
      ambientFadeStops: other.ambientFadeStops,
      ambientFadeHeight:
          lerpDouble(ambientFadeHeight, other.ambientFadeHeight, t) ?? ambientFadeHeight,
      enableAmbientFade: t < 0.5 ? enableAmbientFade : other.enableAmbientFade,
    );
  }
}
